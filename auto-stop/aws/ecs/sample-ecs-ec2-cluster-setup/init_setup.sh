#!/usr/bin/env bash
# Manual bootstrap for Amazon ECS agent on Amazon Linux 2
# Usage:
#   sudo ./init_setup.sh <ECS_CLUSTER_NAME> [AGENT_IMAGE]
# Defaults:
#   AGENT_IMAGE (optional) defaults to public.ecr.aws/ecs/amazon-ecs-agent:latest
# Notes:
#   - Requires root. Will re-exec with sudo if needed.
#   - Logs to /var/log/ecs/manual-bootstrap.log
#   - Works without ecs-init by falling back to a containerized agent.

set -euo pipefail

if [[ ${1:-} == "-h" || ${1:-} == "--help" || ${1:-} == "" ]]; then
  echo "Usage: sudo $0 <ECS_CLUSTER_NAME> [AGENT_IMAGE]"
  echo "Example: sudo $0 Oct03Ecs04Cluster"
  exit 1
fi

CLUSTER_NAME="$1"
AGENT_IMAGE="${2:-public.ecr.aws/ecs/amazon-ecs-agent:latest}"

# Ensure root
if [[ $EUID -ne 0 ]]; then
  echo "Re-running with sudo..."
  exec sudo -E "$0" "$@"
fi

LOG_DIR="/var/log/ecs"
LOG_FILE="$LOG_DIR/manual-bootstrap.log"
mkdir -p "$LOG_DIR" /var/lib/ecs/data /etc/ecs
exec > >(tee -a "$LOG_FILE") 2>&1

echo "==> [BOOTSTRAP] Starting manual ECS agent setup at $(date -Is)"
echo "Cluster: $CLUSTER_NAME" 
echo "Agent image: $AGENT_IMAGE"

# Basic OS sanity
if [[ -f /etc/os-release ]]; then
  . /etc/os-release || true
  echo "OS: ${NAME:-unknown} ${VERSION_ID:-}" || true
fi

echo "==> [STEP] Ensure ecs-init is installed (Amazon Linux 2)"
if ! command -v rpm >/dev/null 2>&1 || ! command -v yum >/dev/null 2>&1; then
  echo "WARN: rpm/yum not found. Skipping ecs-init install (non-AL2?)." 
else
  if ! rpm -q ecs-init >/dev/null 2>&1; then
    echo "Installing ecs-init..."
    yum install -y -q ecs-init || echo "WARN: ecs-init install failed; will rely on container fallback"
  else
    echo "ecs-init already installed"
  fi
fi

echo "==> [STEP] Stop ecs if running and clean previous agent state"
systemctl stop ecs || true
docker rm -f ecs-agent 2>/dev/null || true

ECS_CONFIG="/etc/ecs/ecs.config"
echo "==> [STEP] Configure /etc/ecs/ecs.config"
# Write/update required keys
if grep -q '^ECS_CLUSTER=' "$ECS_CONFIG" 2>/dev/null; then
  sed -i "s/^ECS_CLUSTER=.*/ECS_CLUSTER=${CLUSTER_NAME}/" "$ECS_CONFIG"
else
  echo "ECS_CLUSTER=${CLUSTER_NAME}" >> "$ECS_CONFIG"
fi
if grep -q '^ECS_IMAGE_PULL_BEHAVIOR=' "$ECS_CONFIG" 2>/dev/null; then
  sed -i 's/^ECS_IMAGE_PULL_BEHAVIOR=.*/ECS_IMAGE_PULL_BEHAVIOR=always/' "$ECS_CONFIG"
else
  echo "ECS_IMAGE_PULL_BEHAVIOR=always" >> "$ECS_CONFIG"
fi
if grep -q '^ECS_AGENT_IMAGE=' "$ECS_CONFIG" 2>/dev/null; then
  sed -i "s#^ECS_AGENT_IMAGE=.*#ECS_AGENT_IMAGE=${AGENT_IMAGE}#" "$ECS_CONFIG"
else
  echo "ECS_AGENT_IMAGE=${AGENT_IMAGE}" >> "$ECS_CONFIG"
fi
# Common useful flags
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
  yum install -y -q docker || {
    echo "ERROR: Failed to install docker"; exit 1; }
  systemctl enable --now docker || {
    echo "ERROR: Failed to start docker after install"; exit 1; }
fi
if ! systemctl is-active --quiet docker; then
  echo "ERROR: Docker is not active. Check 'systemctl status docker'"
  exit 1
fi

# Pre-pull agent image (best-effort)
echo "==> [STEP] Pre-pull ECS agent image: $AGENT_IMAGE"
docker pull "$AGENT_IMAGE" || echo "WARN: pre-pull failed; ecs-init or fallback may pull later"

# Try systemd path first if ecs-init present
echo "==> [STEP] Try starting ecs.service via systemd"
if systemctl list-unit-files | grep -q '^ecs.service'; then
  timeout 30s systemctl enable --now ecs || true
  if ! systemctl is-active --quiet ecs; then
    echo "ecs.service not active yet; retrying"
    timeout 20s systemctl restart ecs || true
    sleep 5
  fi
fi

if systemctl is-active --quiet ecs; then
  echo "SUCCESS: ecs.service is active"
else
  echo "==> [FALLBACK] Starting containerized ecs-agent"
  docker rm -f ecs-agent 2>/dev/null || true
  docker run -d --name ecs-agent --restart=on-failure:10 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/log/ecs/:/log \
    -v /var/lib/ecs/data:/data \
    --net=host \
    -e ECS_LOGFILE=/log/ecs-agent.log \
    -e ECS_DATADIR=/data \
    -e ECS_CLUSTER="${CLUSTER_NAME}" \
    -e ECS_ENABLE_TASK_IAM_ROLE=true \
    -e ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true \
    "$AGENT_IMAGE"
  echo "Waiting for agent to initialize..."
  sleep 8
  docker ps -a --filter name=ecs-agent --no-trunc || true
fi

# Verify registration (best effort: check agent log for registration line and cluster)
echo "==> [CHECK] Checking agent log for registration"
for i in $(seq 1 18); do
  if grep -q "Registered container instance with cluster" /var/log/ecs/ecs-agent.log 2>/dev/null; then
    echo "Agent registration detected in ecs-agent.log"
    break
  fi
  echo "Awaiting agent registration... ($i/18)"
  sleep 5
done
echo "==> [CHECK] Validating cluster name in logs"
if grep -E "cluster=\"${CLUSTER_NAME}\"|clusterArn=.*${CLUSTER_NAME}" /var/log/ecs/ecs-agent.log 2>/dev/null | tail -n 1; then
  echo "Cluster validation passed"
else
  echo "WARN: Could not confirm cluster name '${CLUSTER_NAME}' in logs yet. It may take a few more seconds."
fi

echo "==> [CHECK] Final status"
systemctl status ecs --no-pager || true
if docker ps | grep -q ecs-agent; then
  echo "ecs-agent container is running"
else
  echo "ecs-agent container is not running (may be using ecs.service if active)"
fi

echo "==> [DONE] Manual bootstrap complete at $(date -Is)"
