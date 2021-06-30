#__________________________________________________________
#
# Organization moid Ouptut
#__________________________________________________________

output "organization_moid" {
  description = "moid of the Intersight Organization."
  value       = data.intersight_organization_organization.organization_moid.id
}

#__________________________________________________________
#
# IP Pool Output
#__________________________________________________________

output "ip_pool" {
  description = "moid of the IP Pool"
  value       = module.ip_pool.ip_pool_moid
}


#__________________________________________________________
#
# Kubernetes Policies Outputs
#__________________________________________________________

output "k8s_instance_small" {
  description = "moid of the Small Kubernetes Instance Type."
  value       = module.k8s_instance_small.worker_profile_moid
}

output "k8s_instance_medium" {
  description = "moid of the Medium Kubernetes Instance Type."
  value       = module.k8s_instance_medium.worker_profile_moid
}

output "k8s_instance_large" {
  description = "moid of the Large Kubernetes Instance Type."
  value       = module.k8s_instance_large.worker_profile_moid
}

output "k8s_network_cidr" {
  description = "moid of the Kubernetes CIDR Policy."
  value       = module.k8s_vm_network_policy.network_policy_moid
}

output "k8s_nodeos_config" {
  description = "moid of the Kubernetes Node OS Config Policy."
  value       = module.k8s_vm_network_policy.sys_config_policy_moid
}

output "k8s_trusted_registry" {
  depends_on = [
    module.k8s_trusted_registry
  ]
  description = "moid of the Kubernetes Trusted Registry Policy."
  value       = module.k8s_trusted_registry[0].trusted_registry_moid
}

output "k8s_version_policy" {
  description = "moid of the Kubernetes Version Policy."
  value       = module.k8s_version_policy.version_policy_moid
}

output "k8s_vm_infra_policy" {
  description = "moid of the Kubernetes VM Infrastructure Policy."
  value       = module.k8s_vm_infra_policy.infra_config_moid
}


#__________________________________________________________
#
# Kubernetes Cluster Outputs
#__________________________________________________________

output "iks_cluster" {
  description = "moid of the IKS Cluster."
  value       = module.iks_cluster.cluster_moid
}

output "master_profile" {
  description = "moid of the Master Node Profile."
  value       = module.master_profile.node_group_profile_moid
}

output "worker_profile" {
  description = "moid of the Worker Node Profile."
  value = trimspace(<<-EOT
  %{if var.worker_desired_size != "0"~}${module.worker_profile[0].node_group_profile_moid}
  %{else~}blank
  %{endif~}
  EOT
  )
}
