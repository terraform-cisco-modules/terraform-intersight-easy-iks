#______________________________________________
#
# kubeconfigs outputs
#______________________________________________

# output "cluster_names" {
#   description = "Intersight Kubernetes Service Cluster Names."
#   value       = {
#     for k in sort(keys(
#       data.intersight_kubernetes_cluster.kubeconfigs)
#     ) : k => data.intersight_kubernetes_cluster.kubeconfigs[k].results[0].name
#   }
# }

output "kubeconfigs" {
  description = "The Intersight Kubernetes Service kubeconfigs output."
  value = {
    for k in sort(keys(
      data.intersight_kubernetes_cluster.kubeconfigs)
      ) : k => {
      kube_config = base64decode(data.intersight_kubernetes_cluster.kubeconfigs[k].results[0].kube_config)
    }
  }
}
