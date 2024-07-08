resource "tfe_variable_set" "ddr_vault_config" {
  name        = "ddr_vault_config_${data.tfe_project.project.name}"
  description = "A set of example variables"
  global      = false
}

resource "tfe_project_variable_set" "ddr_vault_config" {
  variable_set_id = tfe_variable_set.ddr_vault_config.id
  project_id      = data.tfe_project.project.id
}

resource "tfe_variable" "ddr_vault_cluster_public_endpoint" {
  key             = "ddr_vault_cluster_public_endpoint"
  value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
  category        = "terraform"
  variable_set_id = tfe_variable_set.ddr_vault_config.id
}

resource "tfe_variable" "ddr_vault_cluster_root_token" {
  key             = "ddr_vault_cluster_root_token"
  value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_root_token
  category        = "terraform"
  sensitive       = true
  variable_set_id = tfe_variable_set.ddr_vault_config.id
}
