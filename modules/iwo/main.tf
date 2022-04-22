#__________________________________________________________
#
# Get Outputs from the kubeconfigs Workspace
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

#______________________________________________________________________
#
# Deploy the Intersight Workload Optimizer Pod using the Helm Provider
#______________________________________________________________________

resource "helm_release" "iwo_k8s_collector" {
  name      = "iwok8scollector"
  namespace = "default"
  #  namespace = "iwo-collector"
  chart = "https://prathjan.github.io/helm-chart/iwok8scollector-0.6.2.tgz"
  set {
    name  = "iwoServerVersion"
    value = "8.0"
  }
  set {
    name  = "collectorImage.tag"
    value = "8.0.6"
  }
  set {
    name  = "targetName"
    value = "${var.cluster_name}_sample"
  }
}
