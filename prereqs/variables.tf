variable "oauth_token_id" {
  type = string
}
variable "repo_identifier" {
  type = string
}
variable "repo_branch" {
  type = string
  default = "main"
}
variable "aws_account_id" {
  type = string
}
variable "my_email" {
  type = string
}
variable "region" {
  type = string
  default = "us-west-2"
}
variable "resource_prefix" {
  type = string
  default = "ddr"
}
variable "tfc_project_name" {
  type = string
}
variable "tfc_organization" {
  type = string
}

#### env vars
variable "HCP_CLIENT_ID" {
type = string
}
variable "HCP_CLIENT_SECRET" {
type = string
}
variable "HCP_PROJECT_ID" {
type = string
}
variable "TFE_ORGANIZATION" {
type = string
}
variable "TFC_WORKLOAD_IDENTITY_AUDIENCE" {
type = string
default = "ddr"
}
variable "TFE_TOKEN" {
type = string
}
