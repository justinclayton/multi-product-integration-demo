# ## REQUIRED VARIABLES ##

# variable "resource_prefix" {
# type        = string
# description = "A prefix for all resources in this workspace"
# }

variable "region" {
  type        = string
  description = "The region in which to create resources."
}

# variable "workspace_name" {
# type        = string
# description = "The name of the Terraform Cloud workspace running this code"
# }


# ### TODO: these come from a varset: they should probably
# ### be renamed with a prefix to indicate this

variable "aws_account_id" {
  type = string
}

variable "tfc_organization" {
  type = string
}

variable "tfc_project_name" {
  type = string
}

variable "ddr_tfc_project_name" {
  type    = string
  default = null
}

# ## OTHER VARIABLES

# variable "hvn_cloud" {
# type          = string
# # description = "The cloud provider for the HCP HVN. Must be one of `aws`, `azure`, or `gcp`."
# description   = "The cloud provider for the HCP HVN. Currently, only `aws` is supported."
# default       = "aws"
# }

# variable "hvn_cidr_block" {
# type        = string
# description = "The CIDR block for the HCP HVN."
# default     = "172.25.32.0/20"
# }

# variable "vpc_cidr_block" {
# type        = string
# description = "The CIDR range to create the AWS VPC with"
# default     = "10.0.0.0/16"
# }

# variable "vpc_public_subnets" {
# type        = list(string)
# description = "A list of public subnet CIDR ranges to create"
# default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }

# variable "vpc_private_subnets" {
# type        = list(string)
# description = "A list of private subnet CIDR ranges to create"
# default     = []
# }
