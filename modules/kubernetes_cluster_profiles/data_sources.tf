#__________________________________________________________
#
# Get outputs from the Organization Policies Workspace
#__________________________________________________________

# data "terraform_remote_state" "kubernetes_policies" {
#   backend = "local"
#   config = {
#     path = "../kubernetes_policies/terraform.tfstate"
#   }
# }

data "terraform_remote_state" "kubernetes_policies" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.tfc_workspace
    }
  }
}

