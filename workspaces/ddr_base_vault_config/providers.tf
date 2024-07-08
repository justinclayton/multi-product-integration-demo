provider "vault" {
  address = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint

  # If we've not yet bootstrapped... use an admin token for auth
  # otherwise, use dynamic creds (by setting token to null)
  token = var.auth_method == "admin_token" ? data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_root_token : null

  namespace = "admin"
}

provider "tfe" {
  hostname     = "app.terraform.io"
  organization = var.tfc_organization
}
