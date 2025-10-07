locals {
  # User data to enforce ECS cluster and start agent in an idempotent way
  user_data = <<-EOT
    #!/bin/bash
    set -euxo pipefail

    LOG_FILE=/var/log/ecs/bootstrap.log
    mkdir -p /var/log/ecs || true
    exec > >(tee -a "$LOG_FILE") 2>&1

    echo "==> [BOOTSTRAP] Starting ECS node bootstrap at $(date -Is)"

    # Ensure directories
    mkdir -p /etc/ecs /var/log/ecs /var/lib/ecs/data

    echo "==> [STEP] Stop ecs if running and clean previous agent state"
    systemctl stop ecs || true
    docker rm -f ecs-agent 2>/dev/null || true

    echo "==> [STEP] Configure /etc/ecs/ecs.config"
    ECS_CONFIG="/etc/ecs/ecs.config"
    if grep -q '^ECS_CLUSTER=' "$ECS_CONFIG" 2>/dev/null; then
      sed -i 's/^ECS_CLUSTER=.*/ECS_CLUSTER=${var.cluster_name}/' "$ECS_CONFIG"
    else
      echo "ECS_CLUSTER=${var.cluster_name}" >> "$ECS_CONFIG"
    fi
    if grep -q '^ECS_IMAGE_PULL_BEHAVIOR=' "$ECS_CONFIG" 2>/dev/null; then
      sed -i 's/^ECS_IMAGE_PULL_BEHAVIOR=.*/ECS_IMAGE_PULL_BEHAVIOR=always/' "$ECS_CONFIG"
    else
      echo "ECS_IMAGE_PULL_BEHAVIOR=always" >> "$ECS_CONFIG"
    fi
    if grep -q '^ECS_AGENT_IMAGE=' "$ECS_CONFIG" 2>/dev/null; then
      sed -i 's#^ECS_AGENT_IMAGE=.*#ECS_AGENT_IMAGE=public.ecr.aws/ecs/amazon-ecs-agent:latest#' "$ECS_CONFIG"
    else
      echo "ECS_AGENT_IMAGE=public.ecr.aws/ecs/amazon-ecs-agent:latest" >> "$ECS_CONFIG"
    fi
    if ! grep -q '^ECS_ENABLE_TASK_IAM_ROLE=' "$ECS_CONFIG" 2>/dev/null; then
      echo "ECS_ENABLE_TASK_IAM_ROLE=true" >> "$ECS_CONFIG"
    fi
    if ! grep -q '^ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=' "$ECS_CONFIG" 2>/dev/null; then
      echo "ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true" >> "$ECS_CONFIG"
    fi
    echo "-- $ECS_CONFIG --"
    cat "$ECS_CONFIG" || true

    echo "==> [STEP] Clear previous registration data"
    rm -rf /var/lib/ecs/data/* || true

    echo "==> [STEP] Ensure/Start Docker"
    if ! systemctl enable --now docker; then
      echo "Docker not installed; installing..."
      yum install -y -q docker || true
      systemctl enable --now docker || true
    fi
    systemctl is-active docker

    echo "==> [STEP] Pre-pull ECS agent image"
    AGENT_IMAGE="public.ecr.aws/ecs/amazon-ecs-agent:latest"
    docker pull "$AGENT_IMAGE" || echo "WARN: pre-pull failed; ecs-init or fallback may pull later"

    echo "==> [STEP] Enable and start ECS agent"
    timeout 30s systemctl enable --now ecs || true
    if ! systemctl is-active --quiet ecs; then
      echo "ECS not active yet, retrying start..."
      timeout 20s systemctl restart ecs || true
      sleep 5
    fi

    if ! systemctl is-active --quiet ecs; then
      echo "==> [FALLBACK] ecs.service is not active; starting ECS agent via Docker container"
      docker rm -f ecs-agent 2>/dev/null || true
      docker run -d --name ecs-agent --restart=on-failure:10 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /var/log/ecs/:/log \
        -v /var/lib/ecs/data:/data \
        --net=host \
        -e ECS_LOGFILE=/log/ecs-agent.log \
        -e ECS_DATADIR=/data \
        -e ECS_CLUSTER=${var.cluster_name} \
        -e ECS_ENABLE_TASK_IAM_ROLE=true \
        -e ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true \
        "$AGENT_IMAGE" || true
      echo "Waiting 8s for ecs-agent to initialize"
      sleep 8
      docker ps -a --filter name=ecs-agent --no-trunc || true
    fi

    echo "==> [CHECK] ECS agent service status"
    systemctl status ecs --no-pager || true

    echo "==> [CHECK] Tail ECS agent log (last 50 lines if present)"
    test -f /var/log/ecs/ecs-agent.log && tail -n 50 /var/log/ecs/ecs-agent.log || echo "No ecs-agent.log yet"

    echo "==> [DONE] Bootstrap complete at $(date -Is)"
  EOT
}
