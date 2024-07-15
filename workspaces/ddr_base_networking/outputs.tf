output "hvn_id" {
  value = hcp_hvn.main.hvn_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.public_subnets
}

output "subnet_cidrs" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "hvn_sg_id" {
  value = module.aws_hcp_network_config.security_group_id
}

module "ddr_outputs" {
  source           = "github.com/hashicorp/ddr-base//modules/ddr_outputs?ref=main"
  tfc_organization = var.tfc_organization
  tfc_project_name = var.tfc_project_name

  outputs = {
    hvn_id       = hcp_hvn.main.hvn_id
    vpc_id       = module.vpc.vpc_id
    subnet_ids   = join(",", module.vpc.public_subnets)
    subnet_cidrs = join(",", module.vpc.public_subnets_cidr_blocks)
    hvn_sg_id    = module.aws_hcp_network_config.security_group_id
  }
}
