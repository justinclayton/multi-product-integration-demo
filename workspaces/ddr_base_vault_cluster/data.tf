data "terraform_remote_state" "networking" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces = {
      name = "ddr_base_networking"
    }
  }
}
