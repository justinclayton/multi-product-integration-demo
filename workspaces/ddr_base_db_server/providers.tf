provider "doormat" {}

locals {
  workspace_name = "ddr_base_db_server" # see if we can get programmatically grab this from the workspace itself one day
}
data "doormat_aws_credentials" "creds" {
  provider = doormat
  role_arn = "arn:aws:iam::${var.aws_account_id}:role/tfc-doormat-role_${local.workspace_name}"
}

provider "aws" {
  region     = var.region
  access_key = data.doormat_aws_credentials.creds.access_key
  secret_key = data.doormat_aws_credentials.creds.secret_key
  token      = data.doormat_aws_credentials.creds.token
}

provider "hcp" {}

provider "tfe" {
  hostname     = "app.terraform.io"
  organization = var.tfc_organization
}
