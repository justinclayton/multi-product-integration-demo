data "terraform_remote_state" "ddr_base_vault_cluster" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces   = {
      name = "ddr_base_vault_cluster"
    }
  }
}
