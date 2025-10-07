resource "aws_cloudwatch_log_group" "nginx" {
  name              = "/ecs/${var.cluster_name}/nginx"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.cluster_name}-nginx"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      cpu       = 128
      memory    = 256
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.nginx.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "nginx"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "nginx" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.service_desired_count
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200

  depends_on = [
    aws_ecs_cluster_capacity_providers.attach,
    aws_autoscaling_group.ecs
  ]
}
