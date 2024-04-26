resource "bitbucket_project" "this" {
  for_each = var.bitbucket_projects

  workspace   = each.value.workspace
  name        = each.value.name
  key         = each.value.key
  description = each.value.description
  is_private  = each.value.is_private
}


resource "bitbucket_repository" "this" {
  for_each = var.bitbucket_repositories
  
  name = each.value.name
  project_key = bitbucket_project.this[each.value.project_key].key
  workspace = each.value.workspace
  enable_pipelines = each.value.enable_pipelines
  language = each.value.language
  is_private = each.value.is_private
  
}