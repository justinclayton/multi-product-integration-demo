terraform {
  cloud {
    organization = "justin-clayton-sandbox"

    workspaces {
      name = "ddr_base"
      project = "justin-clayton"
    }
  }
}
