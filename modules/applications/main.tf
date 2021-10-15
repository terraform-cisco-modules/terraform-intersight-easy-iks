#__________________________________________________________
#
# Get Outputs from the kubeconfig Workspace
#__________________________________________________________

data "terraform_remote_state" "kubeconfig" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.tfc_workspace
    }
  }
}

locals {
  # IKS Cluster Name
  cluster_name = data.terraform_remote_state.kubeconfig.outputs.cluster_name
  # Kubernetes Configuration File
  kubeconfig = yamldecode(data.terraform_remote_state.kubeconfig.outputs.kubeconfig)
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
