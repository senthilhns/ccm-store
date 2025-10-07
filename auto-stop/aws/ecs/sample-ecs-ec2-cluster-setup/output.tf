output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = aws_ecs_cluster.this.arn
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.ecs.name
}

output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.ecs.arn
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.ecs.id
}

output "security_group_id" {
  description = "Security Group ID for ECS instances"
  value       = aws_security_group.ecs.id
}

output "key_pair_name" {
  description = "The name of the SSH key pair created in AWS"
  value       = aws_key_pair.ecs_key_pair.key_name
}

output "private_key_pem" {
  description = "PEM-encoded private key for SSH access (sensitive)"
  value       = tls_private_key.ecs_key.private_key_pem
  sensitive   = true
}

output "task_definition_arn" {
  description = "ECS task definition ARN (nginx)"
  value       = aws_ecs_task_definition.nginx.arn
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.nginx.name
}

output "service_arn" {
  description = "ECS service ARN"
  value       = aws_ecs_service.nginx.arn
}

output "log_group_name" {
  description = "CloudWatch Log Group for nginx"
  value       = aws_cloudwatch_log_group.nginx.name
}
