variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for GKE and network resources"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}
