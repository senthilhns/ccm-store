variable "delegate_token" {
  description = "The Harness delegate token for authentication."
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "The Harness account ID."
  type        = string
}

variable "is_add_k8s_cluster_connector" {
  description = "Whether to create the Harness Kubernetes cluster connector."
  type        = bool
  default     = false
}

variable "name_prefix" {
  description = "Prefix for resource names (e.g., EKS, VPC, etc.)"
  type        = string
}
