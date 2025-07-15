terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.32.0, < 5.0.0"
    }
    harness = {
      source  = "harness/harness"
       version = ">= 0.37.4, < 0.38.0"
    }
  }
}
