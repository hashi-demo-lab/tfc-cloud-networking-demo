provider "aws" {
  region = var.region
}

provider "google" {
  project = var.gcp_project_id
  region  = "global"
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = "global"
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