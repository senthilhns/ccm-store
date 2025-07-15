terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    harness = {
      source  = "harness/harness"
       version = ">= 0.37.4, < 0.38.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # AWS Mumbai
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
