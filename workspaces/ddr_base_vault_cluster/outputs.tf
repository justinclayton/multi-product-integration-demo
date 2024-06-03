output "vault_public_endpoint" {
  value = hcp_vault_cluster.vault_cluster.vault_public_endpoint_url
}

output "vault_root_token" {
  value = hcp_vault_cluster_admin_token.provider.token
  sensitive = true
}

output "vault_cluster_id" {
  value = hcp_vault_cluster.vault_cluster.cluster_id
}

# Passthrough outputs to enable cascading plans
output "vpc_id" {
  value = data.terraform_remote_state.networking.outputs.vpc_id
}

output "subnet_ids" {
  value = data.terraform_remote_state.networking.outputs.subnet_ids
}

output "subnet_cidrs" {
  value = data.terraform_remote_state.networking.outputs.subnet_cidrs
}

output "hvn_sg_id" {
  value = data.terraform_remote_state.networking.outputs.hvn_sg_id
}
