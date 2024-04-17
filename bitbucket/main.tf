resource "bitbucket_project" "example" {
  workspace   = "mgl-network-poc"
  name        = "Example Project"
  key         = "EXP"
  description = "An example project"
  is_private  = true
}