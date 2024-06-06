data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}

resource "tfe_variable_set" "prereqs" {
  name        = "ddr_base_prereqs_${var.tfc_project_name}"
  description = "A set of variables used by all workspaces"
  global      = false
}

# bind the variable set to the project
resource "tfe_project_variable_set" "prereqs" {
    variable_set_id = tfe_variable_set.prereqs.id
    project_id      = data.tfe_project.project.id
}

### TERRAFORM VARS ###

resource "tfe_variable" "oauth_token_id" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "oauth_token_id"
  value           = var.oauth_token_id
}
resource "tfe_variable" "repo_identifier" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "repo_identifier"
  value           = var.repo_identifier
}
resource "tfe_variable" "repo_branch" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "repo_branch"
  value           = var.repo_branch
}
resource "tfe_variable" "aws_account_id" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "aws_account_id"
  value           = var.aws_account_id
}
resource "tfe_variable" "my_email" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "my_email"
  value           = var.my_email
}
resource "tfe_variable" "region" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "region"
  value           = var.region
}
resource "tfe_variable" "resource_prefix" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "resource_prefix"
  value           = var.resource_prefix
}
resource "tfe_variable" "tfc_project_name" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "tfc_project_name"
  value           = var.tfc_project_name
}
resource "tfe_variable" "tfc_organization" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "terraform"
  key             = "tfc_organization"
  value           = var.tfc_organization
}

### ENV VARS ###

resource "tfe_variable" "HCP_CLIENT_ID" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "env"
  key             = "HCP_CLIENT_ID"
  value           = var.HCP_CLIENT_ID
}
resource "tfe_variable" "HCP_CLIENT_SECRET" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "env"
  key             = "HCP_CLIENT_SECRET"
  value           = var.HCP_CLIENT_SECRET
}
resource "tfe_variable" "HCP_PROJECT_ID" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "env"
  key             = "HCP_PROJECT_ID"
  value           = var.HCP_PROJECT_ID
}
resource "tfe_variable" "TFE_ORGANIZATION" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "env"
  key             = "TFE_ORGANIZATION"
  value           = var.TFE_ORGANIZATION
}
resource "tfe_variable" "TFC_WORKLOAD_IDENTITY_AUDIENCE" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "env"
  key             = "TFC_WORKLOAD_IDENTITY_AUDIENCE"
  value           = var.TFC_WORKLOAD_IDENTITY_AUDIENCE
}
resource "tfe_variable" "TFE_TOKEN" {
  variable_set_id = tfe_variable_set.prereqs.id
  category        = "env"
  key             = "TFE_TOKEN"
  value           = var.TFE_TOKEN
}
