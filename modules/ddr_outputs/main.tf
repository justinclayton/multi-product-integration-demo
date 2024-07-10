data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}

data "tfe_variable_set" "variable_set" {
  name         = local.tfc_variable_set_name
  organization = var.tfc_organization
}

resource "tfe_variable" "ddr_outputs" {
  for_each        = var.outputs
  variable_set_id = data.tfe_variable_set.variable_set.id
  category        = var.type

  ## only append "ddr_" to the key if the type is "terraform".
  ## usually env vars need to be called something specific
  key   = var.type == "terraform" ? "ddr_${each.key}" : each.key
  value = each.value
}

# resource "tfe_variable" "ddr_hvn_id" {
# variable_set_id = tfe_variable_set.ddr_base_networking.id
# category        = "terraform"

# key   = "ddr_hvn_id"
# value = hcp_hvn.main.hvn_id
# }
