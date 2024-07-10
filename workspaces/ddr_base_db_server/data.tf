data "terraform_remote_state" "networking" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces   = {
      name = "ddr_base_networking"
    }
  }
}

locals {
  # ddr_hvn_id       = data.terraform_remote_state.networking.outputs.hvn_id
  ddr_vpc_id       = data.terraform_remote_state.networking.outputs.vpc_id
  ddr_subnet_ids   = data.terraform_remote_state.networking.outputs.subnet_ids
  ddr_subnet_cidrs = data.terraform_remote_state.networking.outputs.subnet_cidrs
  ddr_hvn_sg_id    = data.terraform_remote_state.networking.outputs.hvn_sg_id
}
