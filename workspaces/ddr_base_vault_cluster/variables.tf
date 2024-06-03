variable "tfc_organization" {
  type = string
}

variable "vault_cluster_tier" {
  type        = string
  description = "The paid tier of the HCP Vault cluster. Defaults to `plus_small`."
  default     = "plus_small"
}
