provider "hcp" {}
provider "tfe" {
  hostname     = "app.terraform.io"
  organization = var.tfc_organization
}
