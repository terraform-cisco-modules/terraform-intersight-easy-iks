#__________________________________________________________
#
# Kubernetes Cluster Profile Variables
#__________________________________________________________

variable "kubernetes_cluster_profiles" {
  default = {
    default = {
      action                 = "Deploy"
      addons_policy_moid     = []
      container_runtime_moid = ""
      description            = ""
      ip_pool_moid           = "**REQUIRED**"
      network_cidr_moid      = "**REQUIRED**"
      node_pools = {
        action                  = "No-op"
        desired_size            = 1
        description             = ""
        min_size                = 1
        max_size                = 3
        node_type               = "ControlPlaneWorker"
        ip_pool_moid            = ""
        kubernetes_labels       = []
        kubernetes_version_moid = "**REQUIRED**"
        vm_infra_config_moid    = "**REQUIRED**"
        vm_instance_type_moid   = "**REQUIRED**"
      }
      nodeos_configuration_moid          = "**REQUIRED**"
      load_balancer_count                = 3
      organization                       = "default"
      ssh_public_key                     = "ssh_public_key_1"
      ssh_user                           = "iksadmin"
      tags                               = []
      trusted_certificate_authority_moid = ""
      wait_for_complete                  = false
      node_pools                         = {}
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Cluster Profile Variable Map.
  * action - Action to perform on the Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * addons_policy_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor|kubernetes-dashboard} or [].
  * container_runtime_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.
  * description - A description for the policy.
  * ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.
  * network_cidr_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.
  * node_pools -   This is the Variable Block for both Control Plane Nodes and Worker Nodes.
    - action - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
    - description - A description for the Policy.
    - desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.
    - ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.  If not Assigned it will assign the ip_pool assigned to the cluster.
    - kubernetes_cluster_moid - Name of the Kubernetes Cluster Profile.
    - kubernetes_labels - List of key/value Attributes to Assign to the control plane node configuration.
    - kubernetes_version_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.
    - max_size - Maximum number of nodes desired in this node pool.  Range is 1-128.
    - min_size - Minimum number of nodes desired in this node pool.  Range is 1-128.
    - node_type - The node type:
      * ControlPlane - Node will be marked as a control plane node.
      * ControlPlaneWorker - Node will be both a controle plane and a worker.
      * Worker - Node will be marked as a worker node.
    - organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
    - vm_instance_type_moid - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.
    - vm_infra_config_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.

  * nodeos_configuration_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.
  * load_balancer_count - Number of load balancer addresses to deploy. Range is 1-999.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * ssh_public_key - The SSH Public Key should be ssh_public_key_{1|2|3|4|5}.  This will point to the ssh_public_key variable that will be used.
  * ssh_user - SSH Username for node login.
  * tags - tags - List of key/value Attributes to Assign to the Profile.
  * trusted_certificate_authority_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles
  * wait_for_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.
  EOT
  type = map(object(
    {
      action                 = optional(string)
      addons_policy_moid     = optional(set(string))
      container_runtime_moid = optional(string)
      description            = optional(string)
      ip_pool_moid           = string
      network_cidr_moid      = string
      node_pools = map(object(
        {
          action                  = optional(string)
          description             = optional(string)
          desired_size            = optional(number)
          ip_pool_moid            = optional(string)
          kubernetes_labels       = optional(list(map(string)))
          kubernetes_version_moid = string
          max_size                = optional(number)
          min_size                = optional(number)
          node_type               = string
          vm_instance_type_moid   = string
          vm_infra_config_moid    = string
        }
      ))
      nodeos_configuration_moid          = string
      trusted_certificate_authority_moid = optional(string)
      load_balancer_count                = optional(number)
      organization                       = optional(string)
      ssh_public_key                     = string
      ssh_user                           = string
      tags                               = optional(list(map(string)))
      wait_for_complete                  = optional(bool)
    }
  ))
}

variable "ssh_public_key_1" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 1."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_2" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_3" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_4" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_5" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}


#__________________________________________________________
#
# Kubernetes Cluster Profiles Module
#__________________________________________________________

module "kubernetes_cluster_profiles" {
  source   = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_profiles"
  for_each = local.kubernetes_cluster_profiles
  action   = each.value.action
  container_runtime_moid = length(
    regexall("r[a-zA-Z0-9]+", coalesce(each.value.container_runtime_moid, "####"))
  ) > 0 ? local.container_runtime_policies[each.value.container_runtime_moid] : ""
  description         = each.value.description != "" ? each.value.description : "${each.key} IKS Cluster."
  ip_pool_moid        = local.ip_pools[each.value.ip_pool_moid]
  load_balancer_count = each.value.load_balancer_count
  name                = each.key
  network_cidr_moid   = local.network_cidr_policies[each.value.network_cidr_moid]
  org_moid            = local.org_moids[each.value.organization].moid
  ssh_public_key = length(
    regexall("1", each.value.ssh_public_key)) > 0 ? var.ssh_public_key_1 : length(
    regexall("2", each.value.ssh_public_key)) > 0 ? var.ssh_public_key_2 : length(
    regexall("3", each.value.ssh_public_key)) > 0 ? var.ssh_public_key_3 : length(
    regexall("4", each.value.ssh_public_key)) > 0 ? var.ssh_public_key_4 : length(
    regexall("5", each.value.ssh_public_key)
  ) > 0 ? var.ssh_public_key_5 : ""
  ssh_user                  = each.value.ssh_user
  nodeos_configuration_moid = local.nodeos_configuration_policies[each.value.nodeos_configuration_moid]
  tags                      = each.value.tags != [] ? each.value.tags : local.tags
  trusted_certificate_authority_moid = length(
    each.value.trusted_certificate_authority_moid
  ) > 0 ? local.trusted_certificate_authorities[each.value.trusted_certificate_authority_moid] : ""
  wait_for_completion = each.value.wait_for_complete
}

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

module "kubernetes_cluster_addons" {
  depends_on = [
    module.kubernetes_cluster_profiles
  ]
  source   = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_addons"
  for_each = local.kubernetes_cluster_profiles
  addons = [
    for a in each.value.addons_policy_moid :
    {
      moid = local.addons_policies["${a}"].moid
      name = local.addons_policies["${a}"].name
    }
  ]
  kubernetes_cluster_moid = module.kubernetes_cluster_profiles[each.key].cluster_moid
  name                    = "${each.key}_addons"
  org_moid                = local.org_moids[each.value.organization].moid
  tags                    = each.value.tags != [] ? each.value.tags : local.tags
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
