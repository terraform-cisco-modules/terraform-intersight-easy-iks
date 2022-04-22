#__________________________________________________________
#
# Get Outputs from the kubeconfig Workspace
#__________________________________________________________

data "terraform_remote_state" "local_kubeconfigs" {
  for_each = { for k, v in local.tfc_workspaces : k => v if v.backend == "local" }
  backend  = each.value.backend
  config = {
    path = "${each.value.kubeconfig_dir}terraform.tfstate"
  }
}

data "terraform_remote_state" "remote_kubeconfigs" {
  for_each = { for k, v in local.tfc_workspaces : k => v if v.backend == "remote" }
  backend  = each.value.backend
  config = {
    organization = each.value.organization
    workspaces = {
      name = each.value.workspace
    }
  }
}

locals {
  # Output Sources for Policies and Pools
  tfc_workspaces = {
    for k, v in var.tfc_workspaces : k => {
      backend        = v.backend
      kubeconfig_dir = v.kubeconfig_dir != null ? v.kubeconfig_dir : "../kubeconfigs/"
      organization   = v.organization != null ? v.organization : "default"
      workspace      = v.workspace != null ? v.workspace : "kubeconfigs"
    }
  }

  # Kubernetes Configuration File
  kubeconfigs = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_kubeconfigs[0].outputs, "kubeconfigs", {}
    ) : lookup(data.terraform_remote_state.remote_kubeconfigs[0].outputs, "kubeconfigs", {}
  )

  kubeconfig = yamldecode(local.kubeconfigs[var.cluster_name].kube_config)
}


#_____________________________________________________________________
#
# Deploy Applications using the Helm Provider
#_____________________________________________________________________

resource "helm_release" "helm_chart" {
  for_each  = var.helm_release
  chart     = each.value.chart
  name      = each.value.name
  namespace = each.value.namespace
  dynamic "set" {
    for_each = each.value.set
    name     = set.value.name
    value    = set.value.value == "cluster_name" ? "${var.cluster_name}_sample" : set.value.value
  }
}

resource "kubectl_manifest" "manifest" {
  for_each  = var.kubectl_manifest
  yaml_body = each.value.yaml_body
}
