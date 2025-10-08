output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.nginx.name
}

output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.nginx.id
}

output "task_definition_arn" {
  description = "The ARN of the task definition"
  value       = aws_ecs_task_definition.nginx.arn
}

output "task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "task_role_arn" {
  description = "The ARN of the ECS task role"
  value       = aws_iam_role.ecs_task.arn
}

output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.ecs_logs.name
}

output "security_group_id" {
  description = "The ID of the security group for the Fargate service"
  value       = aws_security_group.ecs_service.id
}

output "service_url" {
  description = "The URL to access the service"
  value       = length(aws_ecs_service.nginx.load_balancer) > 0 ? "http://${one(aws_ecs_service.nginx.load_balancer[*].dns_name)}" : "No load balancer configured"
  
  # This will be null if no load balancer is attached
  depends_on = [aws_ecs_service.nginx]
}
