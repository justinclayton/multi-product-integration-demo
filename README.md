
# Demos Done Right (DDR) - Base Environment

## Overview

This repository contains the necessary Terraform code to deploy one or more HashiCorp products to enable field demos. The goal is to provide a consistent, repeatable, and easily deployable environment for HashiCorp Solution Engineers, Solutions Architects, and others to showcase the HashiCorp stack.

Currently, the following products are supported:

- [x] HCP Vault
- [ ] HCP Terraform
- [ ] HCP Boundary
- [ ] HCP Packer
- [ ] HCP Consul
- [ ] Nomad Enterprise

Once the base environment is deployed, you can use any of the applicable DDR demos (TODO: add link) to add the additional configuration necessary to showcase a given feature, use case, or user journey.

### Repository Structure

The repository is structured into multiple Terraform workspaces. The main workspace is responsible for creating and orchestrating the deployment of other workspaces, which maintain distinct states. This allows for a stepped approach to deploying the environment, as well as the ability to deploy and manage each product independently by toggling various inputs.

## Prerequisites

Currently, you will need to bring your own accounts and credentials to get this environment up and running. Here's a list of what you will need:

- A Doormat-created AWS sandbox account [Docs](https://docs.prod.secops.hashicorp.services/doormat/aws/create_individual_sandbox_account/)
- A Doormat-enrolled HCP Terraform Account [Docs - Only Steps 1-5!](https://docs.prod.secops.hashicorp.services/doormat/tf_provider/#onboard-tfc-organization-to-doormat)
- An HCP account with an organization-scoped service principal [Docs](https://developer.hashicorp.com/hcp/docs/hcp/admin/iam/service-principals#organization-level-service-principals-1)
- An HCP Terraform organization and user token [Docs](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#tokens)
- A pre-configured OAuth connection between HCP Terraform and GitHub [Docs](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github).
  - Once created, note your OAuth Token ID.  This can be found by navigating in TFC to Org "Settings" --> "Version Control - Providers" --> "OAuth Token Id"


## Getting Started

```
make
```

<!-- ### Preparing your TFC account:

1) Create a new Project (I called mine "hashistack")
2) Create a new Variable Set (again, I called mine "hashistack") and scope it to your previously created Project
3) Populate the variable set with the following variables:

| Key | Value | Sensitive? | Type |
|-----|-------|------------|------|
|aws_account_id|\<your AWS account ID\>|no|terraform|
|boundary_admin_password|\<intended boundary admin password\>|yes|terraform|
|my_email|\<your email\>|no|terraform|
|nomad_license|\<your nomad ent license\>|yes|terraform|
|region|\<the region which will be used on HCP and AWS\>|no|terraform|
|resource_prefix|\<will be used to consistently name resources - 3-36 characters.  Can only contain letters, numbers and hyphens\>|no|terraform|
|tfc_organization|\<your TFC account name\>|no|terraform|
|HCP_CLIENT_ID|\<HCP Service Principal Client ID\>|no|env|
|HCP_CLIENT_SECRET|\<HCP Service Principal Client Secret\>|yes|env|
|HCP_PROJECT_ID|\<your HCP Project ID retrieved from HCP\>|no|env|
|TFC_WORKLOAD_IDENTITY_AUDIENCE|\<can be literally anything\>|no|env|
|TFE_TOKEN|\<TFC User token\>|yes|env|
|TFC_ORGANIZATION|\<your TFC account name\>|no|env|

4) Create a new workspace within your TFC project called "0_control-workspace", attaching it to this VCS repository, specifying the working directory as "0_control-workspace"
5) Create the following workspace variables within "0_control-workspace":

| Key | Value | Sensitive? | Type |
|-----|-------|------------|------|
|oauth_token_id|\<the ot- ID of your OAuth connection\>|no|terraform|
|repo_identifier|<your GH org>/multi-product-integration-demo|no|terraform|
|repo_branch|main|no|terraform|
|tfc_project_id|\<the prj- ID of your TFC Project\>|no|terraform|

## Building the Nomad AMI using Packer

1) navigate to the packer directory
```
cd packer/
```
2) paste your doormat generated AWS credentials, exporting them to your shell
```
export AWS_ACCESS_KEY_ID=************************
export AWS_SECRET_ACCESS_KEY=************************
export AWS_SESSION_TOKEN=************************
```
3) export your HCP_CLIENT_ID, HCP_CLIENT_SECRET, and HCP_PROJECT_ID to your shell
```
export HCP_CLIENT_ID=************************
export HCP_CLIENT_SECRET=************************
export HCP_PROJECT_ID=************************
```
4) Trigger a packer build specifying a pre-existing, publicly accessible subnet of your AWS account and your targeted region for build to happen within
```
packer build -var "subnet_id=subnet-xxxxxxxxxxxx" -var "region=xxxxx" ubuntu.pkr.hcl
```

## Triggering the deployment

Now comes the easy part, simply trigger a run on "0_control-workspace" and watch the environment unfold!

Once the run is complete, you can access each tool by:
- **HCP Consul**: Navigate to the cluster in HCP and generate an admin token
- **HCP Vault**: Navigate to the cluster in HCP and generate an admin token
- **HCP Boundary**: Navigate to the cluster in HCP or via the Desktop app:
  - *username*: admin
  - *password*: this is whatever you set in the variable set
- **Nomad Ent**: The "5_nomad-cluster" workspace will have an output containing the public ALB endpoint to access the Nomad UI.  The Admin token for this can be retrieved from Vault using
```
vault kv get -mount=hashistack-admin/ nomad_bootstrap/SecretID
``` -->

## Shoutouts
Huge thanks to Daniel Schneider for his work on [djschnei21/multi-product-integration-demo](https://github.com/djschnei21/multi-product-integration-demo), which highly influenced our approach in building this.
