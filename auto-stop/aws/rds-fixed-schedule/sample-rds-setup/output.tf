output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_username" {
  description = "The master username for the RDS instance"
  value       = aws_db_instance.mysql.username
}

output "region" {
  description = "The AWS region used for deployment"
  value       = var.region
}

output "db_identifier" {
  description = "The identifier of the RDS database"
  value       = var.db_identifier
}

output "vpc_id" {
  description = "The VPC ID used for RDS"
  value       = var.vpc_id
}

output "subnet_ids" {
  description = "The subnet IDs used for RDS"
  value       = var.subnet_ids
}

output "schedule_name_tag" {
  description = "The value of the Schedule tag on the RDS instance"
  value       = var.schedule_name_tag
}
