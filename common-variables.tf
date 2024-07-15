variable "aws_account_id" {
  type = string
}

variable "my_email" { # used only for boundary config
  type = string
}

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
