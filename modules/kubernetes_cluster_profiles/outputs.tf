#__________________________________________________________
#
# Intersight Global Ouptuts
#__________________________________________________________

output "endpoint" {
  description = "Intersight URL."
  value       = local.endpoint
}

output "org_moid" {
  description = "moid of the Intersight Organization."
  value       = local.org_moid
}

#__________________________________________________________
#
# Global Variable Outputs
#__________________________________________________________

output "tags" {
  description = "Tags to be Associated with Objects Created in Intersight."
  value       = local.tags
}


#__________________________________________________________
#
# Kubernetes Cluster Outputs
#__________________________________________________________

output "cluster_profiles" {
  description = "moid of the Kubernetes Cluster Profiles."
  value = {
    for k in sort(keys(intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles)) : k => {
      cluster_moid = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[k].associated_cluster[0].moid
      name         = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[k].name
      profile_moid = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[k].moid
      kube_config  = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[k].kube_config[0].kube_config
    }
  }
}
