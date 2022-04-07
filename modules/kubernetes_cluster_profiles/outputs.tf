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

output "kubernetes_cluster_profiles" {
  description = "moid of the Kubernetes Cluster Profiles."
  value = {
    for v in sort(keys(intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles)) : v => {
      cluster_moid = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[v].associated_cluster[0].moid
      profile_moid = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[v].moid
    }
  }
}
