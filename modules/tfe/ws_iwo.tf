#__________________________________________________________
#
# IWO Workspaces: {tenant_name}_{cluster_name}_iwo
#__________________________________________________________

module "iwo_workspaces" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  depends_on = [
    module.tfc_agent_pool
  ]
  for_each          = var.iks_cluster
  agent_pool        = module.tfc_agent_pool.tfc_agent_pool
  auto_apply        = true
  description       = "${var.tenant_name}_${each.value.cluster_name} - IWO Workspace."
  execution_mode    = "agent"
  name              = "${var.tenant_name}_${each.value.cluster_name}_iwo"
  terraform_version = var.terraform_version
  tfc_oath_token    = var.tfc_oath_token
  tfc_org_name      = var.tfc_organization
  vcs_repo          = var.vcs_repo
  working_directory = "iwo"
}

output "iwo_workspaces" {
  description = "Terraform Cloud IWO Workspace ID(s)."
  value       = { for v in sort(keys(module.iwo_workspaces)) : v => module.iwo_workspaces[v] }
}

#__________________________________________________________
#
# IWO Variables: {tenant_name}_{cluster_name}_iwo
#__________________________________________________________

module "iwo_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.iwo_workspaces
  ]
  for_each     = var.iks_cluster
  category     = "terraform"
  workspace_id = module.iwo_workspaces["${each.value.cluster_name}"].workspace.id
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
      description = "${var.tenant_name}_${each.value.cluster_name} Kube Config Workspace."
      key         = "ws_kube"
      value       = "${var.tenant_name}_${each.value.cluster_name}_kube"
    }
  }
}