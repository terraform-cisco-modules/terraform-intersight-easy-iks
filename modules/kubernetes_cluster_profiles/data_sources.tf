#__________________________________________________________
#
# Get outputs from the Organization Policies Workspace
#__________________________________________________________

data "terraform_remote_state" "k8s_policies" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_k8s_policies
    }
  }
}

