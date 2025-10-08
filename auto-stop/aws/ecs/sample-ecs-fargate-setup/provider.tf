terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
  
  default_tags {
    tags = merge(
      var.tags,
      {
        Environment = "dev"
        Terraform   = "true"
      }
    )
  }
}

# # AWS Provider for us-east-1 (required for some resources like CloudFront)
# provider "aws" {
#   alias  = "us_east_1"
#   region = "us-east-1"
#
#   default_tags {
#     tags = merge(
#       var.tags,
#       {
#         Environment = "dev"
#         Terraform   = "true"
#       }
#     )
#   }
# }
