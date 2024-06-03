# variable "tfc_organization" {
#   type    = string
# }

variable "tfc_workspace_names" {
  type    = set(string)
  default = ["ddr_base_networking", "ddr_base_vault"]
}

# variable "region" {
#   type = string
# }

variable "variable_set" {
  type = map(string)
}
