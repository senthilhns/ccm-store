variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "eksdemo"
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS nodes."
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "node_count" {
  description = "Number of nodes in the node group."
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "List of instance types for the node group."
  type        = list(string)
  default     = ["t3.xlarge"] # don't change this Harness will need 3.x GB for delegate
}

variable "ssh_key_name" {
  description = "SSH key name for EC2 nodes."
  type        = string
  default     = ""
}

variable "key_pair_name" {
  description = "Name for the EC2 SSH key pair to create."
  type        = string
  default     = "eks-key"
}
