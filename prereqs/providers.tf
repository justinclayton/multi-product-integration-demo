provider "aws" {
  region = var.varset_tf_vars["region"]
}

provider "tfe" {
  hostname     = "app.terraform.io"
  organization = var.varset_tf_vars["tfc_organization"]
}
