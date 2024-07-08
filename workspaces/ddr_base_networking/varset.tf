data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}

resource "tfe_variable_set" "ddr_base_networking" {
  name        = "ddr_base_networking_${data.tfe_project.project.name}"
  description = "Outputs from the ddr_base_networking workspace"
  global      = false
}

resource "tfe_project_variable_set" "ddr_base_networking" {
  variable_set_id = tfe_variable_set.ddr_base_networking.id
  project_id      = data.tfe_project.project.id
}

resource "tfe_variable" "ddr_hvn_id" {
  variable_set_id = tfe_variable_set.ddr_base_networking.id
  category = "terraform"

  key = "ddr_hvn_id"
  value = hcp_hvn.main.hvn_id
}

resource "tfe_variable" "ddr_vpc_id" {
  variable_set_id = tfe_variable_set.ddr_base_networking.id
  category = "terraform"

  key = "ddr_vpc_id"
  value = module.vpc.vpc_id
}

resource "tfe_variable" "ddr_subnet_ids" {
  variable_set_id = tfe_variable_set.ddr_base_networking.id
  category = "terraform"

  key = "ddr_subnet_ids"
  value = module.vpc.public_subnets
}

resource "tfe_variable" "ddr_subnet_cidrs" {
  variable_set_id = tfe_variable_set.ddr_base_networking.id
  category = "terraform"

  key = "ddr_subnet_cidrs"
  value = module.vpc.public_subnets_cidr_blocks
}

resource "tfe_variable" "ddr_hvn_sg_id" {
  variable_set_id = tfe_variable_set.ddr_base_networking.id
  category = "terraform"

  key = "ddr_hvn_sg_id"
  value = module.aws_hcp_network_config.security_group_id
}

