#__________________________________________________________
#
# Intersight Global Ouptuts
#__________________________________________________________

output "endpoint" {
  description = "Intersight URL."
  value       = var.endpoint
}

output "organization" {
  description = "Intersight Organization Name."
  value       = var.organization
}

output "org_moid" {
  description = "moid of the Intersight Organization."
  value       = data.intersight_organization_organization.org_moid.id
}

#__________________________________________________________
#
# Global Variable Outputs
#__________________________________________________________

output "tags" {
  description = "Tags to be Associated with Objects Created in Intersight."
  value       = var.tags
}

output "tenant_name" {
  description = "Name of the Tenant."
  value       = var.tenant_name
}


#__________________________________________________________
#
# IP Pool Output
#__________________________________________________________

output "ip_pools" {
  description = "moid of the IP Pool"
  value       = { for v in sort(keys(module.ip_pools)) : v => module.ip_pools[v].moid }
}


#__________________________________________________________
#
# Kubernetes Policy Outputs
#__________________________________________________________

output "k8s_addons" {
  description = "moid of the Kubernetes CIDR Policies."
  value       = { for v in sort(keys(module.k8s_addons)) : v => module.k8s_addons[v] }
}

output "k8s_network_cidr" {
  description = "moid of the Kubernetes CIDR Policies."
  value       = { for v in sort(keys(module.k8s_vm_network_policy)) : v => module.k8s_vm_network_policy[v].network_policy_moid }
}

output "k8s_nodeos_config" {
  description = "moid of the Kubernetes Node OS Config Policies."
  value       = { for v in sort(keys(module.k8s_vm_network_policy)) : v => module.k8s_vm_network_policy[v].sys_config_policy_moid }
}

output "k8s_runtime_policies" {
  description = "moid of the Kubernetes Runtime Policy."
  value       = var.k8s_runtime_create == true ? {
    for v in sort(keys(module.k8s_runtime_policies)) : v => module.k8s_runtime_policies[v].runtime_policy_moid
  } : {}
}

output "k8s_trusted_registries" {
  description = "moid of the Kubernetes Trusted Registry Policy."
  value       = var.k8s_trusted_create == true ? {
    for v in sort(keys(module.k8s_trusted_registries)) : v => module.k8s_trusted_registries[v].trusted_registry_moid
  } : {}
}

output "k8s_version_policies" {
  description = "moid of the Kubernetes Version Policies."
  value       = { for v in sort(keys(module.k8s_version_policies)) : v => module.k8s_version_policies[v].version_policy_moid }
}

output "k8s_vm_infra_policies" {
  description = "moid of the Kubernetes VM Infrastructure Policies."
  value       = { for v in sort(keys(module.k8s_vm_infra_policies)) : v => module.k8s_vm_infra_policies[v].moid }
}

output "k8s_vm_instance" {
  description = "moid of the Large Kubernetes Instance Type Policies."
  value       = { for v in sort(keys(module.k8s_vm_instance)) : v => module.k8s_vm_instance[v].worker_profile_moid }
}

#__________________________________________________________
#
# Kubernetes Cluster Outputs
#__________________________________________________________

output "iks_cluster" {
  description = "moid of the IKS Cluster."
  value       = { for v in sort(keys(module.iks_cluster)) : v => module.iks_cluster[v].moid }
}
