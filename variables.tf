variable "tfc_workspace_names" {
  type    = set(string) # technically a set, so we can use a for_each loop later
  default = ["ddr_base_networking", "ddr_base_vault_cluster", "ddr_base_vault_config"] # <-- update this variable to include additional workspaces
}

variable "tfc_organization" {
  type = string
}

variable "tfc_project_id" {
  type = string
}

variable "repo_identifier" {
  type = string
}

variable "repo_branch" {
  type = string
}

variable "oauth_token_id" {
  type = string
}
