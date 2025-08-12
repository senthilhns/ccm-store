terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    harness = {
      source  = "harness/harness"
      version = ">= 0.37.4, < 0.38.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "harness" {}

provider "aws" {
  region = "ap-south-1" # AWS Mumbai
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kubectl" {
  apply_retry_count = 15
}
