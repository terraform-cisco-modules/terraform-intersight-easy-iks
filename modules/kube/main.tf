#__________________________________________________________
#
# Get Outputs from the Cluster Workspace
#__________________________________________________________

data "terraform_remote_state" "cluster" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_cluster
    }
  }
}

locals {
  # Intersight Endpoint
  endpoint = data.terraform_remote_state.cluster.outputs.endpoint
  # IKS Cluster Name
  cluster_moid = data.terraform_remote_state.cluster.outputs.iks_cluster
}

#______________________________________________
#
# Get kube_config from IKS Cluster
#______________________________________________

data "intersight_kubernetes_cluster" "kube_config" {
  moid = local.cluster_moid.cluster_1
}
