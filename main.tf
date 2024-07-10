data "tfe_project" "project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization
}

### WORKSPACES ###

resource "tfe_workspace" "workspaces" {
  for_each = toset(local.included_workspaces) # <-- update this variable to include additional workspaces
  name         = each.key
  organization = var.tfc_organization
  project_id   = data.tfe_project.project.id

  vcs_repo {
    identifier     = var.repo_identifier
    oauth_token_id = var.oauth_token_id
    branch         = var.repo_branch
  }

  # Setting `trigger_prefixes` to an empty list disables "automatic run triggering". Now pushes to VCS will not trigger runs.
  trigger_prefixes = []

  working_directory   = "workspaces/${each.key}"
  queue_all_runs      = false
  assessments_enabled = false
  global_remote_state = true
}

### DDR VARIABLE SET ###

## if we do this once for a shared environment, this should be done once, set to global, and not be created per-project
resource "tfe_variable_set" "ddr_outputs" {
  name        = "ddr_outputs_${data.tfe_project.project.name}"
  description = "DDR output values"
  global      = false
}

# bind the variable set to the project
resource "tfe_project_variable_set" "ddr_outputs" {
  variable_set_id = tfe_variable_set.ddr_outputs.id
  project_id      = data.tfe_project.project.id
}

resource "tfe_variable" "ddr_tfc_organization" {
  variable_set_id = tfe_variable_set.ddr_outputs.id
  category        = "terraform"

  key   = "ddr_tfc_organization"
  value = var.tfc_organization
}

resource "tfe_variable" "ddr_tfc_project_name" {
  variable_set_id = tfe_variable_set.ddr_outputs.id
  category        = "terraform"

  key   = "ddr_tfc_project_name"
  value = var.tfc_project_name
}

### RUN ORDER ###

resource "tfe_workspace_run" "ddr_base_networking" {
  workspace_id = tfe_workspace.workspaces["ddr_base_networking"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_vault_cluster" {
  count = var.enable_vault ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_networking ]
  workspace_id = tfe_workspace.workspaces["ddr_base_vault_cluster"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_vault_config" {
  count = var.enable_vault ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_vault_cluster ]
  workspace_id = tfe_workspace.workspaces["ddr_base_vault_config"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_nomad_cluster" {
  count = var.enable_nomad ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_networking ]
  workspace_id = tfe_workspace.workspaces["ddr_base_nomad_cluster"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_nomad_nodes" {
  count = var.enable_nomad ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_nomad_cluster ]
  workspace_id = tfe_workspace.workspaces["ddr_base_nomad_nodes"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_boundary_cluster" {
  count = var.enable_boundary ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_networking ]
  workspace_id = tfe_workspace.workspaces["ddr_base_boundary_cluster"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_boundary_config" {
  count = var.enable_boundary ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_boundary_cluster ]
  workspace_id = tfe_workspace.workspaces["ddr_base_boundary_config"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}

resource "tfe_workspace_run" "ddr_base_db_server" {
  count = var.enable_db ? 1 : 0
  depends_on   = [ tfe_workspace_run.ddr_base_networking ]
  workspace_id = tfe_workspace.workspaces["ddr_base_db_server"].id

  apply {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
  destroy {
    manual_confirm    = false
    wait_for_run      = true
    retry_attempts    = 5
    retry_backoff_min = 5
  }
}
