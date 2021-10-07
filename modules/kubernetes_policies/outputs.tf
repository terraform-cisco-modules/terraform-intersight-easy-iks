#__________________________________________________________
#
# Intersight Provider Ouptuts
#__________________________________________________________

output "endpoint" {
  description = "Intersight URL."
  value       = var.endpoint
}

#__________________________________________________________
#
# Intersight Organization Ouptuts
#__________________________________________________________

output "org_moids" {
  value = {
    for v in sort(keys(data.intersight_organization_organization.org_moid)) : v => {
      moid = data.intersight_organization_organization.org_moid[v].results[0].moid
    }
  }
}


#__________________________________________________________
#
# Intersight Tag Outputs
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
  description = "moid of the IP Pools."
  value       = { for v in sort(keys(module.ip_pools)) : v => module.ip_pools[v].moid }
}


#__________________________________________________________
#
# Kubernetes Policy Outputs
#__________________________________________________________

output "addons_policies" {
  description = "moid of the Kubernetes Addon Policies."
  value       = { for v in sort(keys(module.addons_policies)) : v => module.addons_policies[v] }
}

output "network_cidr_policies" {
  description = "moid of the Kubernetes Network CIDR Policies."
  value       = { for v in sort(keys(module.network_cidr_policies)) : v => module.network_cidr_policies[v].moid }
}

output "nodeos_configuration_policies" {
  description = "moid of the Kubernetes Node OS Config Policies."
  value       = { for v in sort(keys(module.nodeos_configuration_policies)) : v => module.nodeos_configuration_policies[v].moid }
}

output "container_runtime_policies" {
  description = "moid of the Kubernetes Runtime Policies."
  value       = { for v in sort(keys(module.container_runtime_policies)) : v => module.container_runtime_policies[v].moid }
}

output "trusted_certificate_authorities" {
  description = "moid of the Kubernetes Trusted Certificate Authorities Policy."
  value       = { for v in sort(keys(module.trusted_certificate_authorities)) : v => module.trusted_certificate_authorities[v].moid }
}

output "kubernetes_version_policies" {
  description = "moid of the Kubernetes Version Policies."
  value       = { for v in sort(keys(module.kubernetes_version_policies)) : v => module.kubernetes_version_policies[v].moid }
}

output "virtual_machine_infra_config" {
  description = "moid of the Kubernetes Virtual Machine Infrastructure Configuration Policies."
  value       = { for v in sort(keys(module.virtual_machine_infra_config)) : v => module.virtual_machine_infra_config[v].moid }
}

output "virtual_machine_instance_type" {
  description = "moid of the Virtual Machine Instance Type Policies."
  value       = { for v in sort(keys(module.virtual_machine_instance_type)) : v => module.virtual_machine_instance_type[v].moid }
}

