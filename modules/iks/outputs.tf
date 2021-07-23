#__________________________________________________________
#
# Kubernetes Cluster Outputs
#__________________________________________________________

output "iks_cluster" {
  description = "moid of the IKS Cluster."
  value       = module.iks_cluster.cluster_moid
}

output "control_plane_profile" {
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
