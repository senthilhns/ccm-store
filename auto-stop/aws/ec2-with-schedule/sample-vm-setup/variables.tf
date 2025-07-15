variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "demo-ec2-instance"
}

variable "key_name" {
  description = "Name for the SSH key pair"
  type        = string
  default     = "demo-ec2-key"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.nano"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04 in the selected region"
  type        = string
}

variable "schedule_tag" {
  description = "Value for the Schedule tag on the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EC2 instance and security group will be created"
  type        = string
}
