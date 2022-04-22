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

output "org_moid" {
  value = data.intersight_organization_organization.org_moid.results[0].moid
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
  value = merge(
    { for v in sort(keys(intersight_ippool_pool.ip_pools)) : v => intersight_ippool_pool.ip_pools[v].moid },
    { for v in sort(
      keys(data.intersight_ippool_pool.ip_pools)
    ) : v => data.intersight_ippool_pool.ip_pools[v].results[0].moid }
  )
}



#__________________________________________________________
#
# Kubernetes Policy Outputs
#__________________________________________________________

output "addons_policies" {
  description = "moid of the Kubernetes Addon Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_addon_policy.addons)
    ) : v => {
    moid = intersight_kubernetes_addon_policy.addons[v].moid
    name = intersight_kubernetes_addon_policy.addons[v].name
    }
  }
}

output "container_runtime_policies" {
  description = "moid of the Kubernetes Runtime Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_container_runtime_policy.container_runtime)
  ) : v => intersight_kubernetes_container_runtime_policy.container_runtime[v].moid }
}

output "network_cidr_policies" {
  description = "moid of the Kubernetes Network CIDR Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_network_policy.network_cidr)
  ) : v => intersight_kubernetes_network_policy.network_cidr[v].moid }
}

output "nodeos_configuration_policies" {
  description = "moid of the Kubernetes Node OS Config Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_sys_config_policy.nodeos_config)
  ) : v => intersight_kubernetes_sys_config_policy.nodeos_config[v].moid }
}

output "trusted_certificate_authorities" {
  description = "moid of the Kubernetes Trusted Certificate Authorities Policy."
  value = { for v in sort(keys(
    intersight_kubernetes_trusted_registries_policy.trusted_certificate_authorities)
  ) : v => intersight_kubernetes_trusted_registries_policy.trusted_certificate_authorities[v].moid }
}

output "kubernetes_version_policies" {
  description = "moid of the Kubernetes Version Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_version_policy.kubernetes_version)
  ) : v => intersight_kubernetes_version_policy.kubernetes_version[v].moid }
}

output "virtual_machine_infra_config" {
  description = "moid of the Kubernetes Virtual Machine Infrastructure Configuration Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_virtual_machine_infra_config_policy.virtual_machine_infra_config)
  ) : v => intersight_kubernetes_virtual_machine_infra_config_policy.virtual_machine_infra_config[v].moid }
}

output "virtual_machine_instance_type" {
  description = "moid of the Virtual Machine Instance Type Policies."
  value = { for v in sort(keys(
    intersight_kubernetes_virtual_machine_instance_type.virtual_machine_instance_type)
  ) : v => intersight_kubernetes_virtual_machine_instance_type.virtual_machine_instance_type[v].moid }
}

