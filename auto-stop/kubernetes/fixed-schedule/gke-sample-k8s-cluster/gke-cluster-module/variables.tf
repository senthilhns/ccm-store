variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region to deploy the cluster"
  type        = string
}

variable "network" {
  description = "The VPC network name"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork name"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}
