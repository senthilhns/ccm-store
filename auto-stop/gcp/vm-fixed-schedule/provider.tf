terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 6.44.0"
    }
    harness = {
      source  = "harness/harness"
      version = ">= 0.37.4, < 0.38.0"
    }
  }
}

provider "harness" {}
provider "google" {}
