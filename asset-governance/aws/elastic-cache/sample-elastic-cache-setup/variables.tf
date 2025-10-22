variable "aws_region" {
  description = "AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID for ElastiCache."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for ElastiCache subnet group."
  type        = list(string)
}

variable "stack_prefix_id" {
  description = "Prefix to attach to all resource names for identification."
  type        = string
}

variable "cluster_id" {
  description = "ElastiCache cluster_id."
  type        = string
  default     = "redis-cluster"
}

variable "engine" {
  description = "ElastiCache engine type."
  type        = string
  default     = "redis"
}

variable "node_type" {
  description = "ElastiCache node type."
  type        = string
  default     = "cache.t2.micro"
}

variable "num_cache_nodes" {
  description = "Number of cache nodes."
  type        = number
  default     = 1
}

variable "parameter_group_name" {
  description = "Parameter group name."
  type        = string
  default     = "default.redis6.x"
}

variable "port" {
  description = "Port for ElastiCache."
  type        = number
  default     = 6379
}

variable "subnet_group_name" {
  description = "Name for ElastiCache subnet group."
  type        = string
  default     = "elasticache-subnet-group"
}

variable "tags" {
  description = "Tags for ElastiCache resource."
  type        = map(string)
  default = {
    Name        = "redis-cluster"
    Environment = "test"
    Purpose     = "policy-test"
  }
}
