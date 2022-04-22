#______________________________________________
#
# Get kubeconfig from IKS Cluster
#______________________________________________

data "intersight_kubernetes_cluster" "kubeconfigs" {
  for_each = toset(var.cluster_names)
  name     = each.value
}
