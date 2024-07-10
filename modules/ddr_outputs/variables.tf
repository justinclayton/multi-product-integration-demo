variable "inputs" {
  type = map(any)
}

variable "tfc_organization" {
  type = string
}

variable "tfc_project_name" {
  type = string
}

## if var.tfc_variable_set_name is not provided,
## we set to "ddr_outputs_${var.tfc_project_name}"
variable "tfc_variable_set_name" {
  type    = string
  default = ""
}
locals {
  default_variable_set_name = "ddr_outputs_${var.tfc_project_name}"
  tfc_variable_set_name = var.tfc_variable_set_name == "" ? local.default_variable_set_name : var.tfc_variable_set_name
}
