#______________________________________________
#
# Get kube_config from IKS Cluster
#______________________________________________

data "intersight_kubernetes_cluster" "kube_config" {
  name = var.cluster_name
}
