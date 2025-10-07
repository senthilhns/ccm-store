variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ECS instances' security group will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "demo-ecs-ec2-cluster"
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = "demo-ecs-asg"
}

variable "launch_template_name" {
  description = "Name of the Launch Template"
  type        = string
  default     = "demo-ecs-lt"
}

variable "key_name" {
  description = "Name for the SSH key pair"
  type        = string
  default     = "demo-ecs-key"
}

variable "instance_type" {
  description = "EC2 instance type for ECS container instances"
  type        = string
  default     = "t3.small"
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "schedule_tag" {
  description = "Value for the Schedule tag on the ECS container instances for Harness AutoStopping"
  type        = string
}

variable "ami_id" {
  description = "Override AMI ID for ECS instances. If empty, the latest ECS-optimized Amazon Linux 2 AMI will be used via SSM"
  type        = string
  default     = ""
}

variable "ssh_ingress_cidr" {
  description = "List of CIDR blocks allowed to SSH to ECS instances"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "service_name" {
  description = "Name of the ECS Service to create"
  type        = string
  default     = "nginx-ec2-svc"
}

variable "service_desired_count" {
  description = "Desired task count for the ECS Service"
  type        = number
  default     = 1
}

variable "http_ingress_cidr" {
  description = "CIDR blocks allowed to access HTTP (port 80) on the ECS instances"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
