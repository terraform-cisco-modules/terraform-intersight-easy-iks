#__________________________________________________________
#
# Get Outputs from the kubeconfig Workspace
#__________________________________________________________

data "terraform_remote_state" "local_kubeconfig" {
  for_each = { for k, v in local.tfc_workspaces : k => v if v.backend == "local" }
  backend  = each.value.backend
  config = {
    path = "${each.value.kubeconfig_dir}terraform.tfstate"
  }
}

data "terraform_remote_state" "remote_kubeconfig" {
  for_each = { for k, v in local.tfc_workspaces : k => v if v.backend == "remote" }
  backend  = each.value.backend
  config = {
    organization = var.organization
    workspaces = {
      name = var.workspace
    }
  }
}

locals {
  # Output Sources for Policies and Pools
  tfc_workspaces = {
    for k, v in var.tfc_workspaces : k => {
      backend      = v.backend
      organization = v.organization != null ? v.organization : "default"
      policies_dir = v.policies_dir != null ? v.policies_dir : "../kubeconfig/"
      workspace    = v.workspace != null ? v.workspace : "kubeconfig"
    }
  }
  # IKS Cluster Name
  cluster_name = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_kubeconfig[0].outputs.cluster_name
  ) : lookup(data.terraform_remote_state.remote_kubeconfig[0].outputs, "cluster_name", {})
  # Kubernetes Configuration File
  kubeconfig = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    yamldecode(data.terraform_remote_state.local_kubeconfig[0].outputs.cluster_name)
  ) : yamldecode(lookup(data.terraform_remote_state.remote_kubeconfig[0].outputs, "cluster_name", {}))
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
    value    = set.value.value == "cluster_name" ? "${local.cluster_name}_sample" : set.value.value
  }
}

resource "kubectl_manifest" "manifest" {
  for_each  = var.kubectl_manifest
  yaml_body = each.value.yaml_body
}
