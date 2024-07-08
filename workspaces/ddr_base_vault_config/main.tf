resource "null_resource" "ddr_base_vault_config" {}


data "vault_policy_document" "admin" {
  rule {
    path         = "*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "full admin permissions on everything"
  }
}

resource "vault_policy" "admin" {
  name   = "admin"
  policy = data.vault_policy_document.admin.hcl
}

data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}

resource "vault_jwt_auth_backend" "tfc" {
  path               = "tfc/${var.tfc_organization}"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "project_admin_role" {
  role_name = "project_role"
  backend   = vault_jwt_auth_backend.tfc.path

  bound_audiences = ["vault.workload.identity"]
  user_claim      = "terraform_full_workspace"
  role_type       = "jwt"
  token_ttl       = 300
  token_policies  = [vault_policy.admin.name]

  bound_claims = {
    "sub" = join(":", [
      "organization:${var.tfc_organization}",
      "project:${data.tfe_project.project.name}",
      "workspace:*",
      "run_phase:*",
    ])
  }

  bound_claims_type = "glob"
}

resource "tfe_variable_set" "ddr_vault_auth" {
  name        = "ddr_vault_auth_${data.tfe_project.project.name}"
  description = "A set of example variables"
  global      = false
}

resource "tfe_project_variable_set" "ddr_vault_auth" {
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
  project_id      = data.tfe_project.project.id
}

  // Create variables within the variable set
resource "tfe_variable" "tfc_vault_provider_auth" {
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "tfc_vault_addr" {
  key             = "TFC_VAULT_ADDR"
  value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "tfc_vault_namespace" {
  key             = "TFC_VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "tfc_vault_run_role" {
  key             = "TFC_VAULT_RUN_ROLE"
  value           = vault_jwt_auth_backend_role.project_admin_role.role_name
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "tfc_vault_auth_path" {
  key             = "TFC_VAULT_AUTH_PATH"
  value           = vault_jwt_auth_backend.tfc.path
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "vault_addr" {
  key             = "VAULT_ADDR"
  value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "vault_namespace" {
  key             = "VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "vault_auth_method" {
  key             = "auth_method"
  value           = "dynamic_creds"
  category        = "terraform"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "ddr_vault_cluster_public_endpoint" {
  key             = "ddr_vault_cluster_public_endpoint"
  value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
  category        = "terraform"
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}

resource "tfe_variable" "ddr_vault_cluster_root_token" {
  key             = "ddr_vault_cluster_root_token"
  value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_root_token
  category        = "terraform"
  sensitive = true
  variable_set_id = tfe_variable_set.ddr_vault_auth.id
}
