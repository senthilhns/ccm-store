terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke-network" {
  source = "./gke-network-module"
  project_id = var.project_id
  region     = var.region
}

module "gke-cluster" {
  source = "./gke-cluster-module"
  project_id  = var.project_id
  region      = var.region
  network     = module.gke-network.network
  subnetwork  = module.gke-network.subnetwork
  cluster_name = var.cluster_name
}
