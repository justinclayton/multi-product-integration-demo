variable "enable_vault" {
  type    = bool
  default = true
}

variable "enable_boundary" {
  type    = bool
  default = true
}

variable "enable_packer" {
  type    = bool
  default = true
}

variable "enable_nomad" {
  type    = bool
  default = true
}

variable "enable_db" {
  type    = bool
  default = true
}

locals {
  default_workspaces  = ["ddr_base_networking"]
  vault_workspaces    = var.enable_vault ? ["ddr_base_vault_cluster", "ddr_base_vault_config"] : []
  boundary_workspaces = var.enable_boundary ? ["ddr_base_boundary_cluster", "ddr_base_boundary_config"] : []
  nomad_workspaces    = var.enable_boundary ? ["ddr_base_nomad_cluster", "ddr_base_nomad_nodes"] : []

  db_workspaces       = var.enable_db ? ["ddr_base_db_server"] : []
  included_workspaces = concat(local.default_workspaces, local.vault_workspaces, local.boundary_workspaces, local.nomad_workspaces, local.db_workspaces)
}

variable "tfc_organization" {
  type = string
}

variable "tfc_project_name" {
  type = string
}

variable "repo_identifier" {
  type    = string
  default = "hashicorp/ddr-base"
}

variable "repo_branch" {
  type        = string
  description = "main"
}

variable "oauth_token_id" {
  type = string
}
