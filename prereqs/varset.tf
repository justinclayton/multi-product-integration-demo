# # Create a variable set
# # https://www.terraform.io/docs/providers/tfe/r/variable_set.html
# # populate it with:
# # - resource_prefix
# # - region
# # - others? everything in terraform.tfvars maybe?

# resource "tfe_variable_set" "name" {
#   name = "value"

# }

# oauth_token_id = "ot-9DZEK54NBZnGtSxz"
# repo_identifier = "justinclayton/multi-product-integration-demo"
# repo_branch = "testing"
# tfc_project_id = "prj-YFYX7k1zUvnpbj8d" # justin-clayton


# # auth_method = "dynamic_creds"
# # TFC_VAULT_ADDR =
# # TFC_VAULT_AUTH_PATH =
# # TFC_VAULT_NAMESPACE =
# # TFC_VAULT_PROVIDER_PATH
# # TFC_VAULT_RUN_ROLE =
# # VAULT_ADDR =
# # VAULT_NAMESPACE =

# # from variable set hashistack
# aws_account_id = "744108226776"
# my_email = "justin.clayton@hashicorp.com"
# region = "us-west-2"
# resource_prefix = "jcbasetest1"
# tfc_organization = "justin-clayton-sandbox"
# TFE_ORGANIZATION = "justin-clayton-sandbox"

data "tfe_project" "project" {
  name         = var.varset_tf_vars["tfc_project_name"]
  organization = var.varset_tf_vars["tfc_organization"]
}

resource "tfe_variable_set" "prereqs" {
  name        = "ddr_base_prereqs"
  description = "A set of variables used by all workspaces"
  global      = false
}

# bind the variable set to the project
resource "tfe_project_variable_set" "prereqs" {
    variable_set_id = tfe_variable_set.prereqs.id
    project_id      = data.tfe_project.project.id
  # project_id      = var.variable_set["tfc_project_id"]
}

# create terraform variables within the variable set
resource "tfe_variable" "prereqs_terraform" {
  for_each = var.varset_tf_vars

  variable_set_id = tfe_variable_set.prereqs.id
  key             = each.key
  value           = each.value
  category        = "terraform"
}

# create env variables within the variable set
resource "tfe_variable" "prereqs_env" {
  for_each = var.varset_env_vars

  variable_set_id = tfe_variable_set.prereqs.id
  key             = each.key
  value           = each.value
  category        = "env"
}
