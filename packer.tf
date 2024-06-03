# resource "hcp_packer_run_task" "registry" {
#   regenerate_hmac = true
# }

# resource "tfe_organization_run_task" "hcp_packer" {
#   organization = var.tfc_organization
#   url          = hcp_packer_run_task.registry.endpoint_url
#   name         = "packer"
#   enabled      = true
#   hmac_key     = hcp_packer_run_task.registry.hmac_key
# }
