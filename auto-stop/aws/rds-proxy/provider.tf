terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    harness = {
      source  = "harness/harness"
      version = ">= 0.38.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "harness" {
  platform_api_key = var.harness_api_key
  account_id       = var.harness_account_id
}
