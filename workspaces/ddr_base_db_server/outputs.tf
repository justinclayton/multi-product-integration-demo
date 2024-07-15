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
  source = "github.com/hashicorp/ddr-base//modules/ddr_outputs?ref=main"
  tfc_organization = var.tfc_organization
  tfc_project_name = var.tfc_project_name

  outputs = {
    rds_cluster_endpoint = aws_rds_cluster.db.endpoint
    rds_cluster_master_username = local.rds_cluster_master_username
    rds_cluster_master_password = local.rds_cluster_master_password
  }
}
