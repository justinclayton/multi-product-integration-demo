terraform {
  cloud {
    organization = "justin-clayton-sandbox"

    workspaces {
      name = "jc-0_control-workspace"
      project = "justin-clayton"
    }
  }
}
