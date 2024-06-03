variable "aws_account_id" {
  type = string
}

variable "resource_prefix" {
  type        = string
  description = "A prefix for all resources in this workspace"
}

variable "region" {
  type        = string
  description = "The region in which to create resources."
}

# variable "workspace_name" {
#   type = string
#   description = "The name of the Terraform Cloud workspace running this code"
# }
