# Security Group for the Fargate service
resource "aws_security_group" "ecs_service" {
  name        = "${var.cluster_name}-service-sg"
  description = "Security group for ECS Fargate service"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-service-sg"
    }
  )
}

# Allow HTTP traffic to the service
resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_service.id
  description       = "Allow HTTP traffic to the Fargate service"
}

# ECS Service
resource "aws_ecs_service" "nginx" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"
  
  # Match deployment settings from EC2-based service
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200
  
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = var.assign_public_ip
  }

  # Enable container auto recovery
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      load_balancer
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_role,
    aws_iam_role_policy_attachment.ecs_task_role
  ]
}
