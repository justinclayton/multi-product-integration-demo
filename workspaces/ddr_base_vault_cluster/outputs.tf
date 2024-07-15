output "vault_public_endpoint" {
  value = hcp_vault_cluster.vault_cluster.vault_public_endpoint_url
}

output "vault_root_token" {
  value     = hcp_vault_cluster_admin_token.provider.token
  sensitive = true
}

output "vault_cluster_id" {
  value = hcp_vault_cluster.vault_cluster.cluster_id
}

module "ddr_outputs" {
  source           = "github.com/hashicorp/ddr-base//modules/ddr_outputs?ref=main"
  tfc_organization = var.tfc_organization
  tfc_project_name = var.tfc_project_name

  outputs = {
    vault_public_endpoint = hcp_vault_cluster.vault_cluster.vault_public_endpoint_url
    vault_root_token      = hcp_vault_cluster_admin_token.provider.token
    vault_cluster_id      = hcp_vault_cluster.vault_cluster.cluster_id
  }
}
