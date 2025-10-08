variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ECS Fargate service will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Fargate service"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "demo-ecs-fargate-cluster"
}

variable "service_name" {
  description = "Name of the ECS Service to create"
  type        = string
  default     = "nginx-fargate-svc"
}

variable "service_desired_count" {
  description = "Desired task count for the ECS Service"
  type        = number
  default     = 1
}

variable "http_ingress_cidr" {
  description = "CIDR blocks allowed to access HTTP (port 80) on the Fargate service"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "container_port" {
  description = "Port that the container will listen on"
  type        = number
  default     = 80
}

variable "container_cpu" {
  description = "CPU units for the container (1024 units = 1 vCPU)"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory for the container in MiB"
  type        = number
  default     = 512
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the Fargate service"
  type        = bool
  default     = true
}

variable "enable_auto_scaling" {
  description = "Whether to enable auto scaling for the Fargate service"
  type        = bool
  default     = false
}

variable "min_capacity" {
  description = "Minimum number of tasks to run (when auto scaling is enabled)"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks to run (when auto scaling is enabled)"
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
