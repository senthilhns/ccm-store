variable "ssh_key_name" {
  description = "SSH key pair name for EC2 instance access"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where OpenSearch will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the OpenSearch domain"
  type        = list(string)
}

variable "domain_name" {
  description = "Name of the OpenSearch domain"
  type        = string
  default     = "test-opensearch-domain"
}

variable "engine_version" {
  description = "Version of OpenSearch/Elasticsearch to use"
  type        = string
  default     = "OpenSearch_1.3"
}

variable "instance_type" {
  description = "Instance type for data nodes"
  type        = string
  default     = "t3.small.search"
}

variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 2
}

variable "ebs_enabled" {
  description = "Whether to attach EBS volumes to data nodes"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "Type of EBS volumes to use"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "Size of EBS volumes in GB"
  type        = number
  default     = 10
}

variable "restrict_public_access" {
  description = "Whether to restrict public access to the domain"
  type        = bool
  default     = true
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the domain"
  type        = list(string)
  default     = []
}

variable "stack_prefix_id" {
  description = "Prefix for resource names"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
