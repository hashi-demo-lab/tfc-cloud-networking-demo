## Variables file

/* variable "namespace" {
  description = "(Optional) - Namespace that will be used for the configuration"
  type        = string
  default     = null
} */

variable "bitbucket_projects" {
  type = map(object({
    name = string
    key = string
    workspace = string
    description = optional(string)
    is_private = bool
  }))
  default = {
    "TestProject" = {
      is_private = false
      key = "TST"
      name = "TestProject"
      workspace = "mgl-network-poc"
    }
  }
}

variable "bitbucket_repositories" {
  type = map(object({
    name = string
    project_key = string
    workspace = string
    enable_pipelines = optional(bool)
    language = optional(string)
    is_private = optional(bool)
  }))
  default = {
    "someRepo2" = {
      name = "testrepo2"
      project_key= "TestProject"
      workspace = "mgl-network-poc"
      is_private = false
      enable_pipelines = true
      language = "other"
    }
  }
}

