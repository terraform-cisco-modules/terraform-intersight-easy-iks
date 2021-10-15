#__________________________________________________________
#
# Kubernetes Cluster Profile Variables
#__________________________________________________________

variable "kubernetes_node_pools" {
  default = {
    default = {
      action                  = "No-op"
      desired_size            = 1
      description             = ""
      min_size                = 1
      max_size                = 3
      node_type               = "**RERQUIRED**"
      ip_pool_moid            = "**REQUIRED**"
      kubernetes_cluster_moid = "**REQUIRED**"
      kubernetes_labels       = []
      kubernetes_version_moid = "**REQUIRED**"
      organization            = "default"
      vm_infra_config_moid    = "**REQUIRED**"
      vm_instance_type_moid   = "**REQUIRED**"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Cluster Profile Variable Map.
  * action - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * description - A description for the Policy.
  * desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.
  * ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.
  * kubernetes_cluster_moid - Name of the Kubernetes Cluster Profile.
  * kubernetes_labels - List of key/value Attributes to Assign to the control plane node configuration.
  * kubernetes_version_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.
  * max_size - Maximum number of nodes desired in this node pool.  Range is 1-128.
  * min_size - Minimum number of nodes desired in this node pool.  Range is 1-128.
  * node_type - The node type:
    * ControlPlane - Node will be marked as a control plane node.
    * ControlPlaneWorker - Node will be both a controle plane and a worker.
    * Worker - Node will be marked as a worker node.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * vm_instance_type_moid - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.
  * vm_infra_config_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.
  EOT
  type = map(object(
    {
      action                  = optional(string)
      description             = optional(string)
      desired_size            = optional(number)
      ip_pool_moid            = string
      kubernetes_cluster_moid = string
      kubernetes_labels       = optional(list(map(string)))
      kubernetes_version_moid = string
      max_size                = optional(number)
      min_size                = optional(number)
      node_type               = string
      organization            = optional(string)
      vm_instance_type_moid   = string
      vm_infra_config_moid    = string
    }
  ))
}

#______________________________________________
#
# Create the Control Plane Profile
#______________________________________________

module "kubernetes_node_pools" {
  depends_on = [
    module.kubernetes_cluster_profiles,
  ]
  source                  = "terraform-cisco-modules/imm/intersight//modules/kubernetes_node_group_profiles"
  for_each                = local.kubernetes_node_pools
  action                  = each.value.action
  description             = each.value.description != "" ? each.value.description : "${each.key} Node Group Profile"
  desired_size            = each.value.desired_size
  kubernetes_cluster_moid = module.kubernetes_cluster_profiles[each.value.kubernetes_cluster_moid].profile_moid
  kubernetes_version_moid = local.kubernetes_version_policies[each.value.kubernetes_version_moid]
  ip_pool_moid            = local.ip_pools[each.value.ip_pool_moid]
  kubernetes_labels       = each.value.kubernetes_labels
  max_size                = each.value.max_size
  min_size                = each.value.min_size
  name                    = each.key
  node_type               = each.value.node_type
}

module "control_plane_node_vm_infra" {
  depends_on = [
    module.kubernetes_node_pools
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_node_vm_infra"
  for_each                  = local.kubernetes_node_pools
  description               = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Virtual machine Infrastructure Provider"
  kubernetes_node_pool_moid = module.kubernetes_node_pools[each.key].moid
  vm_infra_config_moid      = local.virtual_machine_infra_config[each.value.vm_infra_config_moid]
  vm_instance_type_moid     = local.virtual_machine_instance_type[each.value.vm_instance_type_moid]
  name                      = each.key
}
