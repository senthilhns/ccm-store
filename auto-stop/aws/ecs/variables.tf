// Variables for ECS AutoStopping rules and schedule

variable "region" {
  description = "AWS region of the ECS cluster"
  type        = string
}

variable "harness_cloud_connector_id" {
  description = "Harness CCM cloud connector ID"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name (not ARN)"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name (not ARN)"
  type        = string
}

variable "schedule_name" {
  description = "Name of the schedule to be created"
  type        = string
}

variable "time_zone" {
  description = "Time zone for the schedule"
  type        = string
}
