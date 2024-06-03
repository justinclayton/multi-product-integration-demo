variable "aws_account_id" {
  type = string
}

# variable "boundary_admin_password" {
#   type = string
# }


variable "my_email" { # used only for boundary config
  type = string
}

# variable "nomad_license" {
#   type = string
# }

variable "auth_method" { # used only for vault config
  type = string
  default = "admin_token"
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
