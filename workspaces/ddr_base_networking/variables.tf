variable "hvn_cloud" {
  type = string
  # description = "The cloud provider for the HCP HVN. Must be one of `aws`, `azure`, or `gcp`."
  description = "The cloud provider for the HCP HVN. Currently, only `aws` is supported."
  default     = "aws"
}

variable "hvn_cidr_block" {
  type        = string
  description = "The CIDR block for the HCP HVN."
  default     = "172.25.32.0/20"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR range to create the AWS VPC with"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "A list of public subnet CIDR ranges to create"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "A list of private subnet CIDR ranges to create"
  default     = []
}
