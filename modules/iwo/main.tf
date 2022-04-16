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
      policies_dir = v.policies_dir != null ? v.policies_dir : "../kubeconfigs/"
      workspace    = v.workspace != null ? v.workspace : "kubeconfigs"
    }
  }
  # IKS Cluster Name
  cluster_names = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_kubeconfigs[0].outputs, "cluster_names", {}
    ) : lookup(data.terraform_remote_state.remote_kubeconfigs[0].outputs, "cluster_names", {}
  )
  # Kubernetes Configuration File
  kubeconfigs = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    yamldecode(data.terraform_remote_state.local_kubeconfig[0].outputs, "kubeconfigs", {})
    ) : yamldecode(lookup(data.terraform_remote_state.remote_kubeconfig[0].outputs, "kubeconfigs", {})
  )
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
    value = "${local.cluster_name}_sample"
  }
}
