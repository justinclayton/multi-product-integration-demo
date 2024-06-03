terraform {
  required_providers {
    tfe = {
      version = "0.49.0"
    }

    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.66.0"
    }
  }
}
