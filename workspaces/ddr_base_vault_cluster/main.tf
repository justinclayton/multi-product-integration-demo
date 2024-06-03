resource null_resource "vault_cluster" {}

resource "hcp_vault_cluster" "vault_cluster" {
  cluster_id      = "${var.resource_prefix}-vault-cluster"
  tier            = var.vault_cluster_tier
  hvn_id          = data.terraform_remote_state.networking.outputs.hvn_id
  public_endpoint = true
}

resource "hcp_vault_cluster_admin_token" "provider" {
  cluster_id = hcp_vault_cluster.vault_cluster.cluster_id
}
