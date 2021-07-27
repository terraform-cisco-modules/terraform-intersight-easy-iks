locals {
  #__________________________________________________________
  #
  # Intersight and Tenant Variables
  #__________________________________________________________

  endpoint = data.terraform_remote_state.tenant.outputs.endpoint
  organization = data.terraform_remote_state.tenant.outputs.organization
  org_moid = data.terraform_remote_state.tenant.outputs.org_moid
  tags = data.terraform_remote_state.tenant.outputs.tags
  tenant_name = data.terraform_remote_state.tenant.outputs.tenant_name
  #__________________________________________________________
  #
  # IKS Cluster Variables
  #__________________________________________________________

  iks_cluster = {
    for k, v in jsondecode(var.iks_cluster) : k => {
      action_cluster                  = (v.action_cluster != null ? v.action_cluster : "Deploy")
      action_control_plane            = (v.action_control_plane != null ? v.action_control_plane : "No-op")
      action_worker                   = (v.action_worker != null ? v.action_worker : "No-op")
      control_plane_desired_size      = (v.control_plane_desired_size != null ? v.control_plane_desired_size : 1)
      control_plane_k8s_labels        = (v.control_plane_k8s_labels != null ? v.control_plane_k8s_labels : [])
      control_plane_max_size          = (v.control_plane_max_size != null ? v.control_plane_max_size : 3)
      description                     = (v.description != null ? v.description : "")
      ip_pool_moid                    = v.ip_pool_moid
      k8s_addon_policy_moid           = (v.k8s_addon_policy_moid != null ? v.k8s_addon_policy_moid : [])
      k8s_network_cidr_moid           = v.k8s_network_cidr_moid
      k8s_nodeos_config_moid          = v.k8s_nodeos_config_moid
      k8s_registry_moid               = (v.k8s_registry_moid != null ? v.k8s_registry_moid : "")
      k8s_runtime_moid                = (v.k8s_runtime_moid != null ? v.k8s_runtime_moid : "")
      k8s_version_moid                = v.k8s_version_moid
      k8s_vm_infra_moid               = v.k8s_vm_infra_moid
      k8s_vm_instance_type_ctrl_plane = v.k8s_vm_instance_type_ctrl_plane
      k8s_vm_instance_type_worker     = v.k8s_vm_instance_type_worker
      load_balancers                  = (v.load_balancers != null ? v.load_balancers : 3)
      ssh_key                         = v.ssh_key
      ssh_user                        = (v.ssh_user != null ? v.ssh_user : "iksadmin")
      tags                            = (v.tags != null ? v.tags : [])
      wait_for_complete               = (v.wait_for_complete != null ? v.wait_for_complete : false)
      worker_desired_size             = (v.worker_desired_size != null ? v.worker_desired_size : 1)
      worker_k8s_labels               = (v.worker_k8s_labels != null ? v.worker_k8s_labels : [])
      worker_max_size                 = (v.worker_max_size != null ? v.worker_max_size : 4)
    }
  }
  #__________________________________________________________
  #
  # Assign Global Attributes from tenant Workspace
  #__________________________________________________________

  # IP Pool moid's
  ip_pools = data.terraform_remote_state.tenant.outputs.ip_pools
  # Kubernetes Policies moid's
  k8s_addon_policies = data.terraform_remote_state.tenant.outputs.k8s_addon_policies
  k8s_network_cidr = data.terraform_remote_state.tenant.outputs.k8s_network_cidr
  k8s_nodeos_config = data.terraform_remote_state.tenant.outputs.k8s_nodeos_config
  k8s_runtime_policies = data.terraform_remote_state.tenant.outputs.k8s_runtime_policies
  k8s_trusted_registries = data.terraform_remote_state.tenant.outputs.k8s_trusted_registries
  k8s_version_policies = data.terraform_remote_state.tenant.outputs.k8s_version_policies
  k8s_vm_infra_config = data.terraform_remote_state.tenant.outputs.k8s_vm_infra_config
  k8s_vm_instance_type = data.terraform_remote_state.tenant.outputs.k8s_vm_instance_type
}
