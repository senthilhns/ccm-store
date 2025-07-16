variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "db_identifier" {
  description = "unique identifier for the RDS instance and not the database (schema) name"
  type        = string
  default     = "sampledb"
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance and security group will be created"
  type        = string
}

variable "schedule_name_tag" {
  description = "Value for the Schedule tag on the RDS instance"
  type        = string
}
