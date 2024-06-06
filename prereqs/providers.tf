provider "aws" {
  region = var.region
}

provider "tfe" {
  hostname     = "app.terraform.io"
  organization = var.tfc_organization
}
