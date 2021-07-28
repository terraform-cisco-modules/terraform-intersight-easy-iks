#______________________________________________
#
# Get kubeconfig from IKS Cluster
#______________________________________________

data "intersight_kubernetes_cluster" "kubeconfig" {
  name = var.cluster_name
}
