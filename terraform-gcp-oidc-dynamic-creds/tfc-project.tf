# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "tfe" {
  hostname = var.tfc_hostname
}

resource "tfe_variable_set" "creds" {
  name         = "GCP Dynamic Creds: ${var.tfc_workspace_project_name} Project"
  description  = "GCP Auth & Role details for Dynamic AWS Creds"
  organization = var.tfc_organization_name
}


resource "tfe_variable" "project_enable_gcp_provider_auth" {
  key      = "TFC_GCP_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for AWS."

  variable_set_id = tfe_variable_set.creds.id
}

resource "tfe_variable" "project_tfc_gcp_role_arn" {
  key      = "TFC_GCP_WORKLOAD_PROVIDER_NAME"
  value    = google_iam_workload_identity_pool_provider.tfc_provider.name
  category = "env"

  description = "The AWS role arn runs will use to authenticate."

  variable_set_id = tfe_variable_set.creds.id
}

resource "tfe_variable" "tfc_gcp_service_account_email" {


  key      = "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
  value    = google_service_account.tfc_service_account.email
  category = "env"

  description = "The GCP service account email runs will use to authenticate."

  variable_set_id = tfe_variable_set.creds.id
}

resource "tfe_project_variable_set" "creds_to_project" {
  variable_set_id = tfe_variable_set.creds.id
  project_id      = var.tfc_workspace_project_id
}



# Uncomment the following variables and comment out
# tfc_gcp_workload_provider_name if you wish to supply this
# information in separate variables instead!

# resource "tfe_variable" "tfc_gcp_project_number" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_GCP_PROJECT_NUMBER"
#   value    = data.google_project.project.number
#   category = "env"

#   description = "The numeric identifier of the GCP project"
# }

# resource "tfe_variable" "tfc_gcp_workload_pool_id" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_GCP_WORKLOAD_POOL_ID"
#   value    = google_iam_workload_identity_pool.tfc_pool.workload_identity_pool_id
#   category = "env"

#   description = "The ID of the workload identity pool."
# }

# resource "tfe_variable" "tfc_gcp_workload_provider_id" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_GCP_WORKLOAD_PROVIDER_ID"
#   value    = google_iam_workload_identity_pool_provider.tfc_provider.workload_identity_pool_provider_id
#   category = "env"

#   description = "The ID of the workload identity pool provider."
# }



# The following variables are optional; uncomment the ones you need!

# resource "tfe_variable" "tfc_gcp_audience" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_GCP_WORKLOAD_IDENTITY_AUDIENCE"
#   value    = var.tfc_gcp_audience
#   category = "env"

#   description = "The value to use as the audience claim in run identity tokens"
# }

# The following is an example of the naming format used to define variables for
# additional configurations. Additional required configuration values must also
# be supplied in this same format, as well as any desired optional configuration
# values.
#
# Additional configurations can be used to uniquely authenticate multiple aliases
# of the same provider in a workspace, with different roles/permissions in different
# accounts or regions.
#
# See https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/specifying-multiple-configurations
# for more details on specifying multiple configurations.
#
# See https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/gcp-configuration#specifying-multiple-configurations
# for specific requirements and details for the GCP provider.

# resource "tfe_variable" "enable_gcp_provider_auth_other_config" {
#   workspace_id = tfe_workspace.my_workspace.id

#   key      = "TFC_GCP_PROVIDER_AUTH_other_config"
#   value    = "true"
#   category = "env"

#   description = "Enable the Workload Identity integration for GCP for an additional configuration named other_config."
# }
