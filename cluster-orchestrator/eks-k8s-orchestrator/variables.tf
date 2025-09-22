variable "name_prefix" {
  description = "Prefix for resource names (e.g., EKS, VPC, etc.)"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.32"
}