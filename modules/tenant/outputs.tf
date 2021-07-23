#__________________________________________________________
#
# Intersight Endpoint Ouptut
#__________________________________________________________

output "endpoint" {
  description = "Intersight URL."
  value       = var.endpoint
}

#__________________________________________________________
#
# Organization moid Ouptut
#__________________________________________________________

output "organization_moid" {
  description = "moid of the Intersight Organization."
  value       = data.intersight_organization_organization.org_moid.id
}

#__________________________________________________________
#
# IP Pool Output
#__________________________________________________________

output "ip_pools" {
  description = "moid of the IP Pool"
  value       = { for v in sort(keys(module.ip_pools)) : v => module.ip_pools[v] }
}


#__________________________________________________________
#
# Kubernetes Policies Outputs
#__________________________________________________________

output "k8s_vm_instance_small" {
  description = "moid of the Small Kubernetes Instance Type."
  value       = { for v in sort(keys(module.k8s_vm_instance_small)) : v => module.k8s_vm_instance_small[v].worker_profile_moid }
}

output "k8s_vm_instance_medium" {
  description = "moid of the Medium Kubernetes Instance Type."
  value       = { for v in sort(keys(module.k8s_vm_instance_medium)) : v => module.k8s_vm_instance_medium[v].worker_profile_moid }
}

output "k8s_vm_instance_large" {
  description = "moid of the Large Kubernetes Instance Type."
  value       = { for v in sort(keys(module.k8s_vm_instance_large)) : v => module.k8s_vm_instance_large[v].worker_profile_moid }
}

output "k8s_network_cidr" {
  description = "moid of the Kubernetes CIDR Policy."
  value       = { for v in sort(keys(module.k8s_vm_network_policy)) : v => module.k8s_vm_network_policy[v].network_policy_moid }
}

output "k8s_nodeos_config" {
  description = "moid of the Kubernetes Node OS Config Policy."
  value       = { for v in sort(keys(module.k8s_vm_network_policy)) : v => module.k8s_vm_network_policy[v].sys_config_policy_moid }
}

# output "k8s_trusted_registry" {
#   description = "moid of the Kubernetes Trusted Registry Policy."
#   value       = var.k8s_trusted_registry.root_ca != null || var.k8s_trusted_registry.unsigned != null ? module.k8s_trusted_registry[0].trusted_registry_moid : ""
# }

output "k8s_version_policy" {
  description = "moid of the Kubernetes Version Policy."
  value       = { for v in sort(keys(module.k8s_version_policy)) : v => module.k8s_version_policy[v].version_policy_moid }
}

output "k8s_vm_infra_policy" {
  description = "moid of the Kubernetes VM Infrastructure Policy."
  value       = { for v in sort(keys(module.k8s_vm_infra_policy)) : v => module.k8s_vm_infra_policy[v].infra_config_moid }
}


