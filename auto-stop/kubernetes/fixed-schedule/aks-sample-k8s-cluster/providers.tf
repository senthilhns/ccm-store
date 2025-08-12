provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks_cluster.kube_config.host
  client_certificate     = base64decode(module.aks_cluster.kube_config.client_certificate)
  client_key             = base64decode(module.aks_cluster.kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks_cluster.kube_config.cluster_ca_certificate)
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.0.0"
}
