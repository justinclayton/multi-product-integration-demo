provider "aws" {
  region = var.variable_set["region"]
}

provider "tfe" {
  hostname     = "app.terraform.io"
  organization = var.variable_set["tfc_organization"]
}
