#__________________________________________________________
#
# Get Outputs from the kube Workspace
#__________________________________________________________

data "terraform_remote_state" "kube" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_kube
    }
  }
}

locals {
  # IKS Cluster Name
  cluster_name = data.terraform_remote_state.kube.outputs.cluster_name
  # Kubernetes Configuration File
  kube_config = yamldecode(data.terraform_remote_state.kube.outputs.kube_config)
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
