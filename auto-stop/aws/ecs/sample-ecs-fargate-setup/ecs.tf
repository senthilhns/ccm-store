resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

# Fargate capacity providers are managed by AWS and don't need explicit definition
# like EC2 capacity providers do

# CloudWatch Log Group for ECS logs
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.cluster_name}"
  retention_in_days = 7
  tags              = var.tags
}
