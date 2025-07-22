terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.32.0, < 5.0.0"
    }
  }
}

provider "google" {}
