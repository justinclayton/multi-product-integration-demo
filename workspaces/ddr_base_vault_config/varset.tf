# # resource "tfe_variable_set" "ddr_vault_config" {
# #   name        = "ddr_vault_config_${data.tfe_project.project.name}"
# #   description = "A set of example variables"
# #   global      = false
# # }

# # resource "tfe_project_variable_set" "ddr_vault_config" {
# #   variable_set_id = tfe_variable_set.ddr_vault_config.id
# #   project_id      = data.tfe_project.project.id
# # }



# ## Create variables within the variable set
# resource "tfe_variable" "tfc_vault_provider_auth" {
#   key             = "TFC_VAULT_PROVIDER_AUTH"
#   value           = "true"
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "tfc_vault_addr" {
#   key             = "TFC_VAULT_ADDR"
#   value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "tfc_vault_namespace" {
#   key             = "TFC_VAULT_NAMESPACE"
#   value           = "admin"
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "tfc_vault_run_role" {
#   key             = "TFC_VAULT_RUN_ROLE"
#   value           = vault_jwt_auth_backend_role.project_admin_role.role_name
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "tfc_vault_auth_path" {
#   key             = "TFC_VAULT_AUTH_PATH"
#   value           = vault_jwt_auth_backend.tfc.path
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "vault_addr" {
#   key             = "VAULT_ADDR"
#   value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "vault_namespace" {
#   key             = "VAULT_NAMESPACE"
#   value           = "admin"
#   category        = "env"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "vault_auth_method" {
#   key             = "auth_method"
#   value           = "dynamic_creds"
#   category        = "terraform"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "ddr_vault_cluster_public_endpoint" {
#   key             = "ddr_vault_cluster_public_endpoint"
#   value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_public_endpoint
#   category        = "terraform"
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }

# resource "tfe_variable" "ddr_vault_cluster_root_token" {
#   key             = "ddr_vault_cluster_root_token"
#   value           = data.terraform_remote_state.ddr_base_vault_cluster.outputs.vault_root_token
#   category        = "terraform"
#   sensitive       = true
#   variable_set_id = tfe_variable_set.ddr_vault_config.id
# }
