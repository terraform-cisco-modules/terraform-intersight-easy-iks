#______________________________________________
#
# kubeconfig output
#______________________________________________

output "cluster_name" {
  description = "Intersight Kubernetes Service Cluster Name."
  value       = data.intersight_kubernetes_cluster.kubeconfig.results[0].name
}

output "kubeconfig" {
  description = "The Intersight Kubernetes Service kubeconfig output."
  value       = base64decode(data.intersight_kubernetes_cluster.kubeconfig.results[0].kube_config)
}
