data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}
