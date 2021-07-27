#__________________________________________________________
#
# Kube Workspaces: {organization}_{cluster_name}_kube
#__________________________________________________________

module "kube_workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each            = var.iks_cluster
  auto_apply          = true
  description         = "${var.organization}_${each.key} - kube_config Workspace."
  global_remote_state = true
  name                = "${var.organization}_${each.key}_kube"
  terraform_version   = var.terraform_version
  tfc_oath_token      = var.tfc_oath_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "modules/kube"
}

output "kube_workspaces" {
  description = "Terraform Cloud Kube Workspace ID(s)."
  value       = { for v in sort(keys(module.kube_workspaces)) : v => module.kube_workspaces[v] }
}

#__________________________________________________________
#
# Kube Variables: {organization}_{cluster_name}_kube
#__________________________________________________________

module "kube_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.kube_workspaces
  ]
  for_each     = var.iks_cluster
  category     = "terraform"
  workspace_id = module.kube_workspaces["${each.key}"].workspace.id
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
      description = "${var.organization}_${each.key} Cluster Name."
      key         = "cluster_name"
      value       = "${var.organization}_${each.key}"
    },
  }
}
