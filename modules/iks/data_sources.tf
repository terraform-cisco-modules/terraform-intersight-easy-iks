#__________________________________________________________
#
# Get outputs from the Organization Policies Workspace
#__________________________________________________________

# data "terraform_remote_state" "organization" {
#   backend = "local"
#   config = {
#     path = "../organization/terraform.tfstate"
#   }
# }

data "terraform_remote_state" "organization" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.organization
    }
  }
}

