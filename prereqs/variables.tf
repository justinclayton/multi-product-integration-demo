# variable "tfc_organization" {
#   type    = string
# }

variable "tfc_workspace_names" {
  type    = set(string)
  default = ["ddr_base_networking", "ddr_base_vault_cluster", "ddr_base_vault_config"]
}

# variable "region" {
#   type = string
# }

variable "varset_tf_vars" {
  type = map(string)
}

variable "varset_env_vars" {
  type = map(string)
}
