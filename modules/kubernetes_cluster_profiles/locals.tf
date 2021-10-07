locals {
  #__________________________________________________________
  #
  # Intersight and Tenant Variables
  #__________________________________________________________

  endpoint  = data.terraform_remote_state.kubernetes_policies.outputs.endpoint
  org_moids = data.terraform_remote_state.kubernetes_policies.outputs.org_moids
  tags      = data.terraform_remote_state.kubernetes_policies.outputs.tags

  #__________________________________________________________
  #
  # Assign Global Attributes from organization Workspace
  #__________________________________________________________

  # Kubernetes Policies moid's
  addons_policies                 = data.terraform_remote_state.kubernetes_policies.outputs.addons_policies
  container_runtime_policies      = data.terraform_remote_state.kubernetes_policies.outputs.container_runtime_policies
  ip_pools                        = data.terraform_remote_state.kubernetes_policies.outputs.ip_pools
  network_cidr_policies           = data.terraform_remote_state.kubernetes_policies.outputs.network_cidr_policies
  nodeos_config_policies          = data.terraform_remote_state.kubernetes_policies.outputs.nodeos_config_policies
  kubernetes_version_policies     = data.terraform_remote_state.kubernetes_policies.outputs.kubernetes_version_policies
  trusted_certificate_authorities = data.terraform_remote_state.kubernetes_policies.outputs.trusted_certificate_authorities
  virtual_machine_infra_config    = data.terraform_remote_state.kubernetes_policies.outputs.virtual_machine_infra_config
  virtual_machine_instance_type   = data.terraform_remote_state.kubernetes_policies.outputs.virtual_machine_instance_type

  #__________________________________________________________
  #
  # Kubernetes Cluster Profiles Variables
  #__________________________________________________________

  kubernetes_cluster_profiles = {
    for k, v in jsondecode(var.kubernetes_cluster_profiles) : k => {
      action_cluster                      = v.action_cluster != null ? v.action_cluster : "Deploy"
      action_control_plane                = v.action_control_plane != null ? v.action_control_plane : "No-op"
      action_worker                       = v.action_worker != null ? v.action_worker : "No-op"
      addons_policy_moid                  = v.addons_policy_moid != null ? v.addons_policy_moid : []
      container_runtime_moid              = v.container_runtime_moid != null ? v.container_runtime_moid : ""
      control_plane_desired_size          = v.control_plane_desired_size != null ? v.control_plane_desired_size : 1
      control_plane_k8s_labels            = v.control_plane_k8s_labels != null ? v.control_plane_k8s_labels : []
      control_plane_max_size              = v.control_plane_max_size != null ? v.control_plane_max_size : 3
      control_plane_vm_instance_type_moid = v.control_plane_vm_instance_type
      description                         = v.description != null ? v.description : ""
      ip_pool_moid                        = v.ip_pool_moid
      kubernetes_version_moid             = v.kubernetes_version_moid
      network_cidr_moid                   = v.network_cidr_moid
      nodeos_config_moid                  = v.nodeos_config_moid
      load_balancers                      = v.load_balancers != null ? v.load_balancers : 3
      organization                        = v.organization != null ? v.organization : "default"
      ssh_key                             = v.ssh_key
      ssh_user                            = v.ssh_user != null ? v.ssh_user : "iksadmin"
      tags                                = v.tags != null ? v.tags : []
      trusted_certificate_authority_moid  = v.trusted_certificate_authority_moid != null ? v.trusted_certificate_authority_moid : ""
      virtual_machine_infra_config_moid   = v.virtual_machine_infra_config_moid
      wait_for_complete                   = v.wait_for_complete != null ? v.wait_for_complete : false
      worker_desired_size                 = v.worker_desired_size != null ? v.worker_desired_size : 1
      worker_k8s_labels                   = v.worker_k8s_labels != null ? v.worker_k8s_labels : []
      worker_max_size                     = v.worker_max_size != null ? v.worker_max_size : 4
      worker_vm_instance_type_moid        = v.worker_vm_instance_type_moid
    }
  }
}
