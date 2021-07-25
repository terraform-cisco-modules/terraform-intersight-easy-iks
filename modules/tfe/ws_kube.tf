#__________________________________________________________
#
# Kube Workspaces: {tenant_name}_{cluster_name}_kube
#__________________________________________________________

module "kube_workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each            = var.iks_cluster
  auto_apply          = true
  description         = "${var.tenant_name}_${each.value.cluster_name} - kube_config Workspace."
  global_remote_state = true
  name                = "${var.tenant_name}_${each.value.cluster_name}_kube"
  terraform_version   = var.terraform_version
  tfc_oath_token      = var.tfc_oath_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "kube"
}

output "kube_workspaces" {
  description = "Terraform Cloud Kube Workspace ID(s)."
  value       = { for v in sort(keys(module.kube_workspaces)) : v => module.kube_workspaces[v] }
}

#__________________________________________________________
#
# Kube Variables: {tenant_name}_{cluster_name}_kube
#__________________________________________________________

module "kube_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.kube_workspaces
  ]
  for_each     = var.iks_cluster
  category     = "terraform"
  workspace_id = module.kube_workspaces["${each.value.cluster_name}"].workspace.id
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
      description = "${var.tenant_name}_${each.value.cluster_name} Workspace."
      key         = "ws_tenant"
      value       = "${var.tenant_name}_${each.value.cluster_name}"
    },
    #---------------------------
    # Intersight Variables
    #---------------------------
    intersight_apikey = {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    intersight_secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    }
  }
}
