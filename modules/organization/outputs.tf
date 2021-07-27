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
  value       = local.tags
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

output "k8s_addon_policies" {
  description = "moid of the Kubernetes CIDR Policies."
  value       = { for v in sort(keys(module.k8s_addon_policies)) : v => module.k8s_addon_policies[v] }
}

output "k8s_network_cidr" {
  description = "moid of the Kubernetes CIDR Policies."
  value       = { for v in sort(keys(module.k8s_network_cidr)) : v => module.k8s_network_cidr[v].moid }
}

output "k8s_nodeos_config" {
  description = "moid of the Kubernetes Node OS Config Policies."
  value       = { for v in sort(keys(module.k8s_nodeos_config)) : v => module.k8s_nodeos_config[v].moid }
}

output "k8s_runtime_policies" {
  description = "moid of the Kubernetes Runtime Policies."
  value = var.k8s_runtime_create == true ? {
    for v in sort(keys(module.k8s_runtime_policies)) : v => module.k8s_runtime_policies[v].moid
  } : {}
}

output "k8s_trusted_registries" {
  description = "moid of the Kubernetes Trusted Registry Policy."
  value = var.k8s_trusted_create == true ? {
    for v in sort(keys(module.k8s_trusted_registries)) : v => module.k8s_trusted_registries[v].moid
  } : {}
}

output "k8s_version_policies" {
  description = "moid of the Kubernetes Version Policies."
  value       = { for v in sort(keys(module.k8s_version_policies)) : v => module.k8s_version_policies[v].moid }
}

output "k8s_vm_infra_config" {
  description = "moid of the Kubernetes VM Infrastructure Configuration Policies."
  value       = { for v in sort(keys(module.k8s_vm_infra_config)) : v => module.k8s_vm_infra_config[v].moid }
}

output "k8s_vm_instance_type" {
  description = "moid of the Large Kubernetes Instance Type Policies."
  value       = { for v in sort(keys(module.k8s_vm_instance_type)) : v => module.k8s_vm_instance_type[v].moid }
}
