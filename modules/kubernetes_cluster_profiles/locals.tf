locals {
  # Output Sources for Policies and Pools
  tfc_workspaces = {
    for k, v in var.tfc_workspaces : k => {
      backend      = v.backend
      organization = v.organization != null ? v.organization : "default"
      policies_dir = v.policies_dir != null ? v.policies_dir : "../kubernetes_policies/"
      workspace    = v.workspace != null ? v.workspace : "kubernetes_policies"
    }
  }

  #__________________________________________________________
  #
  # Intersight and Tenant Variables
  #__________________________________________________________

  endpoint = var.tfc_workspaces[0][
    "backend"
    ] == "local" ? data.terraform_remote_state.local_policies[0
  ].outputs.endpoint : data.terraform_remote_state.remote_policies[0].outputs.endpoint
  org_moid = var.tfc_workspaces[0][
    "backend"
    ] == "local" ? data.terraform_remote_state.local_policies[0
  ].outputs.org_moid : data.terraform_remote_state.remote_policies[0].outputs.org_moid
  tags = var.tfc_workspaces[0][
    "backend"
    ] == "local" ? data.terraform_remote_state.local_policies[0
  ].outputs.tags : data.terraform_remote_state.remote_policies[0].outputs.tags

  #__________________________________________________________
  #
  # Assign Global Attributes from organization Workspace
  #__________________________________________________________

  # Kubernetes Policies moid's
  addons_policies = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "addons_policies", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "addons_policies", {})
  container_runtime_policies = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "container_runtime_policies", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "container_runtime_policies", {})
  ip_pools = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "ip_pools", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "ip_pools", {})
  network_cidr_policies = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "network_cidr_policies", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "network_cidr_policies", {})
  nodeos_configuration_policies = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "nodeos_configuration_policies", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "nodeos_configuration_policies", {})
  kubernetes_version_policies = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "kubernetes_version_policies", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "kubernetes_version_policies", {})
  trusted_certificate_authorities = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "trusted_certificate_authorities", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "trusted_certificate_authorities", {})
  virtual_machine_infra_config = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "virtual_machine_infra_config", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "virtual_machine_infra_config", {})
  virtual_machine_instance_type = var.tfc_workspaces[0]["backend"] == "local" ? lookup(
    data.terraform_remote_state.local_policies[0].outputs, "virtual_machine_instance_type", {}
  ) : lookup(data.terraform_remote_state.remote_policies[0].outputs, "virtual_machine_instance_type", {})

  #__________________________________________________________
  #
  # Kubernetes Cluster Profiles Variables
  #__________________________________________________________

  kubernetes_cluster_profiles = {
    for k, v in var.kubernetes_cluster_profiles : k => {
      action                    = v.action != null ? v.action : "No-op"
      addons_policies           = v.addons_policies != null ? v.addons_policies : ["default"]
      certificate_configuration = v.certificate_configuration != null ? v.certificate_configuration : false
      cluster_configuration = [
        for key, value in v.cluster_configuration : {
          kubernetes_api_vip  = value.kubernetes_api_vip != null ? value.kubernetes_api_vip : ""
          load_balancer_count = value.load_balancer_count != null ? value.load_balancer_count : 3
          ssh_public_key      = value.ssh_public_key != null ? value.ssh_public_key : 1
        }
      ]
      container_runtime_policy      = v.container_runtime_policy != null ? v.container_runtime_policy : ""
      description                   = v.description != null ? v.description : ""
      ip_pool                       = v.ip_pool
      network_cidr_policy           = v.network_cidr_policy
      node_pools                    = v.node_pools
      nodeos_configuration_policy   = v.nodeos_configuration_policy
      tags                          = v.tags != null ? v.tags : []
      trusted_certificate_authority = v.trusted_certificate_authority != null ? v.trusted_certificate_authority : ""
      wait_for_completion           = v.wait_for_completion != null ? v.wait_for_completion : false
    }
  }

  node_pools_loop = flatten([
    for key, value in local.kubernetes_cluster_profiles : [
      for k, v in value.node_pools : {
        action                     = value.action
        desired_size               = v.desired_size != null ? v.desired_size : 1
        description                = v.description != null ? v.description : ""
        min_size                   = v.min_size != null ? v.min_size : 1
        max_size                   = v.max_size != null ? v.max_size : 3
        name                       = "${key}_${k}"
        node_pool                  = k
        node_type                  = v.node_type != null ? v.node_type : "ControlPlaneWorker"
        ip_pool                    = v.ip_pool != null && v.ip_pool != "" ? v.ip_pool : value.ip_pool
        kubernetes_cluster_profile = key
        kubernetes_labels          = v.kubernetes_labels != null ? v.kubernetes_labels : []
        kubernetes_version_policy  = v.kubernetes_version_policy
        tags                       = value.tags
        vm_infra_config_policy     = v.vm_infra_config_policy
        vm_instance_type_policy    = v.vm_instance_type_policy
      }
    ]
  ])

  kubernetes_node_pools = {
    for k, v in local.node_pools_loop : "${v.kubernetes_cluster_profile}_${v.node_pool}" => v
  }
}
