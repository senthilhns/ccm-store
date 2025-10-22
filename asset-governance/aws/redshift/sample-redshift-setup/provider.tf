terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.17.0"  # Using the version that's already in the lock file
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
  
  required_version = ">= 1.2.0"  # Minimum OpenTofu version
}

provider "aws" {
  region = var.aws_region
}
