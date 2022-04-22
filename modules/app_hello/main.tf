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
# Deploy the Hello-Kubernetes Application Pod using the Helm Provider
#_____________________________________________________________________

resource "helm_release" "hello_iks_app" {
  name      = "helloiksapp"
  namespace = "default"
  chart     = "https://prathjan.github.io/helm-chart/helloiks-0.1.0.tgz"
  set {
    name  = "MESSAGE"
    value = "Hello Intersight Kubernetes Service from Terraform Cloud for Business!!"
  }
}
