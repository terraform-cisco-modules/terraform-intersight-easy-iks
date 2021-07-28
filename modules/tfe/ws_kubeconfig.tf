#__________________________________________________________
#
# Kube Workspaces: {cluster_name}_Kubeconfig
#__________________________________________________________

module "Kubeconfig_workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each            = var.iks_cluster
  auto_apply          = true
  description         = "${each.key} - Kubeconfig Workspace."
  global_remote_state = true
  name                = "${each.key}_Kubeconfig"
  terraform_version   = var.terraform_version
  tfc_oauth_token     = var.tfc_oauth_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "modules/Kubeconfig"
}

output "Kubeconfig_workspaces" {
  description = "Terraform Cloud Kubeconfig Workspace ID(s)."
  value       = { for v in sort(keys(module.kube_workspaces)) : v => module.kube_workspaces[v] }
}

#__________________________________________________________
#
# Kube Variables: {cluster_name}_Kubeconfig
#__________________________________________________________

module "Kubeconfig_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.Kubeconfig_workspaces
  ]
  for_each     = var.iks_cluster
  category     = "terraform"
  workspace_id = module.Kubeconfig_workspaces["${each.key}"].workspace.id
  variable_list = {
    #---------------------------
    # Intersight Variables
    #---------------------------
    apikey = {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    endpoint = {
      description = "Intersight Endpoint."
      key         = "endpoint"
      value       = var.endpoint
    },
    secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    },
    #---------------------------
    # Cluster Variables
    #---------------------------
    cluster_name = {
      description = "${each.key} Cluster Name."
      key         = "cluster_name"
      value       = "${each.key}"
    },
  }
}
