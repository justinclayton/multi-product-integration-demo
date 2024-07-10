resource "terraform_data" "ddr_base_vault_config" {}


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
