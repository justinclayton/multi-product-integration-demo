variable "my_email" {
  type = string
}

variable "oauth_token_id" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "tfc_organization" {
  type = string
}

variable "tfc_project_name" {
  type = string
}

variable "hcp_client_id" {
  type = string
}

variable "hcp_client_secret" {
  type = string
}

variable "hcp_project_id" {
type = string
}

variable "tfe_token" {
  type = string
}

variable "tfc_workload_identity_audience" {
  type    = string
  default = "ddr"
}

variable "resource_prefix" {
  type    = string
  default = "ddr"
}

variable "repo_identifier" {
  type    = string
  default = "hashicorp/ddr-base"
}

variable "repo_branch" {
  type    = string
  default = "main"
}
