#_______________________________________________________________
#
# App Hello Workspaces: {organization}_{cluster_name}_app_hello
#_______________________________________________________________

module "app_hello_workspaces" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  depends_on = [
    module.tfc_agent_pool
  ]
  for_each          = var.iks_cluster
  agent_pool        = module.tfc_agent_pool.tfc_agent_pool
  auto_apply        = true
  description       = "${var.organization}_${each.key} - App Hello Workspace."
  execution_mode    = "agent"
  name              = "${var.organization}_${each.key}_app_hello"
  terraform_version = var.terraform_version
  tfc_oauth_token   = var.tfc_oauth_token
  tfc_org_name      = var.tfc_organization
  vcs_repo          = var.vcs_repo
  working_directory = "modules/app_hello"
}

output "app_hello_workspaces" {
  description = "Terraform Cloud App Hello Workspace ID(s)."
  value       = { for v in sort(keys(module.app_hello_workspaces)) : v => module.app_hello_workspaces[v] }
}

#_______________________________________________________________
#
# App Hello Variables: {organization}_{cluster_name}_app_hello
#_______________________________________________________________

module "app_hello_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.app_hello_workspaces
  ]
  for_each     = var.iks_cluster
  category     = "terraform"
  workspace_id = module.app_hello_workspaces["${each.key}"].workspace.id
  variable_list = {
    #---------------------------
    # Terraform Cloud Variables
    #---------------------------
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    tfc_workspace = {
      description = "${var.organization}_${each.key} Kube Config Workspace."
      key         = "ws_kube"
      value       = "${var.organization}_${each.key}_kube"
    }
  }
}
