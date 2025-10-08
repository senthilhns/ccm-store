resource "aws_cloudwatch_log_group" "nginx" {
  name              = "/ecs/${var.cluster_name}/nginx"
  retention_in_days = 7
  tags              = var.tags
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.cluster_name}-nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"  # Match EC2 task definition
  memory                   = "512"  # Match EC2 task definition
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      cpu       = 128  # Match EC2 task definition
      memory    = 256  # Match EC2 task definition
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

  tags = var.tags
}
