provider "aws" {
  region = var.region
}

terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "tfc-demo-au"

    workspaces {
      name    = "tfc-tenant-config-networks"
      project = "platform_team"
    }
  }

}