#__________________________________________________________
#
# Intersight Global Ouptuts
#__________________________________________________________

output "endpoint" {
  description = "Intersight URL."
  value       = local.endpoint
}

output "org_moids" {
  description = "moid of the Intersight Organization."
  value       = local.org_moids
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
    for v in sort(keys(module.kubernetes_cluster_profiles)) : v => {
      cluster_moid = module.kubernetes_cluster_profiles[v].cluster_moid
      profile_moid = module.kubernetes_cluster_profiles[v].profile_moid
    }
  }
}
