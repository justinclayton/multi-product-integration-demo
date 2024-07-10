data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}

resource "tfe_variable_set" "ddr_vault_cluster" {
  name        = "ddr_vault_cluster_${data.tfe_project.project.name}"
  description = "A set of example variables"
  global      = false
}

resource "tfe_project_variable_set" "ddr_vault_cluster" {
  variable_set_id = tfe_variable_set.ddr_vault_cluster.id
  project_id      = data.tfe_project.project.id
}

resource "tfe_variable" "ddr_vault_cluster_public_endpoint" {
  key             = "ddr_vault_cluster_public_endpoint"
  value           = hcp_vault_cluster.vault_cluster.vault_public_endpoint_url
  category        = "terraform"
  variable_set_id = tfe_variable_set.ddr_vault_cluster.id
}

resource "tfe_variable" "ddr_vault_cluster_root_token" {
  key             = "ddr_vault_cluster_root_token"
  value           = hcp_vault_cluster_admin_token.provider.token
  category        = "terraform"
  sensitive       = true
  variable_set_id = tfe_variable_set.ddr_vault_cluster.id
}
