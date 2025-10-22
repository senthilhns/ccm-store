variable "aws_region" {
  description = "AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID for Redshift."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for Redshift subnet group."
  type        = list(string)
}

variable "cluster_identifier" {
  description = "Unique identifier for the Redshift cluster."
  type        = string
  default     = "redshift-cluster-for-testing"
}

variable "node_type" {
  description = "Node type for the Redshift cluster. Example: ra3.xlplus, ra3.4xlarge"
  type        = string
  default     = "ra3.xlplus"
}

variable "master_username" {
  description = "Master username for the Redshift cluster."
  type        = string
  default     = "awsuser"
}

variable "database_name" {
  description = "The name of the first database to be created when the cluster is created."
  type        = string
  default     = "dev"
}

variable "snapshot_retention_period" {
  description = "The number of days to retain automated snapshots."
  type        = number
  default     = 15
}

variable "snapshot_copy_destination_region" {
  description = "The destination region for cross-region snapshot copies."
  type        = string
  default     = "us-west-2"
}

variable "snapshot_copy_retention_period" {
  description = "The retention period for cross-region snapshot copies."
  type        = number
  default     = 7
}

variable "publicly_accessible" {
  description = "Whether the cluster is publicly accessible."
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name for the Redshift security group."
  type        = string
  default     = "redshift-public-sg-for-testing"
}

variable "subnet_group_name" {
  description = "Name for the Redshift subnet group."
  type        = string
  default     = "redshift-subnet-group-for-testing"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    Name = "redshift-cluster-for-testing"
  }
}

variable "stack_prefix_id" {
  description = "A prefix to add to all resource names for unique identification."
  type        = string
}
