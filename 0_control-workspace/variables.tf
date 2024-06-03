variable "tfc_workspace_names" {
  type    = set(string)
  default = ["ddr_base_networking", "ddr_base_vault"]
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
