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
  nodeos_configuration_policies   = data.terraform_remote_state.kubernetes_policies.outputs.nodeos_configuration_policies
  kubernetes_version_policies     = data.terraform_remote_state.kubernetes_policies.outputs.kubernetes_version_policies
  trusted_certificate_authorities = data.terraform_remote_state.kubernetes_policies.outputs.trusted_certificate_authorities
  virtual_machine_infra_config    = data.terraform_remote_state.kubernetes_policies.outputs.virtual_machine_infra_config
  virtual_machine_instance_type   = data.terraform_remote_state.kubernetes_policies.outputs.virtual_machine_instance_type

  #__________________________________________________________
  #
  # Kubernetes Cluster Profiles Variables
  #__________________________________________________________

  kubernetes_cluster_profiles = {
    for k, v in var.kubernetes_cluster_profiles : k => {
      action                             = v.action != null ? v.action : "Deploy"
      addons_policy_moid                 = v.addons_policy_moid != null ? v.addons_policy_moid : []
      container_runtime_moid             = v.container_runtime_moid != null ? v.container_runtime_moid : ""
      description                        = v.description != null ? v.description : ""
      ip_pool_moid                       = v.ip_pool_moid
      network_cidr_moid                  = v.network_cidr_moid
      node_pools                         = v.node_pools
      nodeos_configuration_moid          = v.nodeos_configuration_moid
      load_balancer_count                = v.load_balancer_count != null ? v.load_balancer_count : 3
      organization                       = v.organization != null ? v.organization : "default"
      ssh_public_key                     = v.ssh_public_key
      ssh_user                           = v.ssh_user != null ? v.ssh_user : "iksadmin"
      tags                               = v.tags != null ? v.tags : []
      trusted_certificate_authority_moid = v.trusted_certificate_authority_moid != null ? v.trusted_certificate_authority_moid : ""
      wait_for_complete                  = v.wait_for_complete != null ? v.wait_for_complete : false
    }
  }

  node_pools_loop = flatten([
    for key, value in var.kubernetes_cluster_profiles : [
      for k, v in value.node_pools : {
        action                  = v.action != null ? v.action : "No-op"
        desired_size            = v.desired_size != null ? v.desired_size : 1
        description             = v.description != null ? v.description : ""
        min_size                = v.min_size != null ? v.min_size : 1
        max_size                = v.max_size != null ? v.max_size : 3
        name                    = "${key}_${k}"
        node_pool               = k
        node_type               = v.node_type != null ? v.node_type : "ControlPlaneWorker"
        ip_pool_moid            = v.ip_pool_moid != null ? v.ip_pool_moid : value.ip_pool_moid
        kubernetes_cluster_moid = key
        kubernetes_labels       = v.kubernetes_labels != null ? v.kubernetes_labels : []
        kubernetes_version_moid = v.kubernetes_version_moid
        vm_infra_config_moid    = v.vm_infra_config_moid
        vm_instance_type_moid   = v.vm_instance_type_moid
      }
    ]
  ])

  kubernetes_node_pools = {
    for k, v in local.node_pools_loop : "${v.kubernetes_cluster_moid}_${v.node_pool}" => v
  }
}
