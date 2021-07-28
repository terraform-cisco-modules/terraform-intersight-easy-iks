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

output "iks_cluster" {
  description = "moid of the IKS Cluster."
  value = {
    for v in sort(keys(module.iks_cluster)) : v => {
      cluster_moid = module.iks_cluster[v].cluster_moid
      profile_moid = module.iks_cluster[v].profile_moid
    }
  }
}
