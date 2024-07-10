module "ddr_outputs" {
  source           = "github.com/justinclayton/multi-product-integration-demo//modules/ddr_outputs?ref=testing"
  tfc_organization = var.tfc_organization
  tfc_project_name = var.tfc_project_name

  type = "env"
  outputs = {
    TFC_VAULT_PROVIDER_AUTH = "true"
    # TFC_VAULT_ADDR          = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
    TFC_VAULT_NAMESPACE     = "admin"
    TFC_VAULT_RUN_ROLE      = vault_jwt_auth_backend_role.project_admin_role.role_name
    TFC_VAULT_AUTH_PATH     = vault_jwt_auth_backend.tfc.path
    # VAULT_ADDR              = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
    VAULT_NAMESPACE         = "admin"
  }
}

module "ddr_outputs" {
  source           = "github.com/justinclayton/multi-product-integration-demo//modules/ddr_outputs?ref=testing"
  tfc_organization = var.tfc_organization
  tfc_project_name = var.tfc_project_name

  type = "terraform"
  outputs = {
    vault_auth_method = "dynamic_creds"
  }
}
