# output "hvn_id" {
#   value = hcp_hvn.main.hvn_id
# }

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "subnet_ids" {
#   value = module.vpc.public_subnets
# }

# output "subnet_cidrs" {
#   value = module.vpc.public_subnets_cidr_blocks
# }

# output "hvn_sg_id" {
#   value = module.aws_hcp_network_config.security_group_id
# }

output "db_server_private_ip" {
  value = aws_instance.database.private_ip
}

output "db_server_public_ip" {
  value = aws_instance.database.public_ip
}

output "rds_cluster_endpoint" {
  value = aws_rds_cluster.db.endpoint
}

output "rds_cluster_master_username" {
  value = local.rds_cluster_master_username
}

output "rds_cluster_master_password" {
  value = local.rds_cluster_master_password
}

module "ddr_outputs" {
  source = "github.com/justinclayton/multi-product-integration-demo//modules/ddr_outputs?ref=testing"
  tfc_organization = var.tfc_organization
  tfc_project_name = var.tfc_project_name

  outputs = {
    db_server_private_ip = aws_instance.database.private_ip
    db_server_public_ip  = aws_instance.database.public_ip
    rds_cluster_endpoint = aws_rds_cluster.db.endpoint
    rds_cluster_master_username = local.rds_cluster_master_username
    rds_cluster_master_password = local.rds_cluster_master_password
  }
}
