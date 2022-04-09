#__________________________________________________________
#
# Kubernetes Cluster Profile Variables
#__________________________________________________________

variable "kubernetes_cluster_profiles" {
  default = {
    default = {
      action                    = "No-op" # Deploy|No-op
      addons_policies           = ["default"]
      certificate_configuration = false
      cluster_configuration = [
        {
          kubernetes_api_vip  = ""
          load_balancer_count = 3
          ssh_public_key      = 1
          # ssh_user            = "iksadmin"
        }
      ]
      container_runtime_policy = "default"
      description              = ""
      ip_pool                  = "default"
      network_cidr_policy      = "default"
      node_pools = {
        "0" = {
          action                    = "No-op"
          desired_size              = 1
          description               = ""
          min_size                  = 1
          max_size                  = 3
          node_type                 = "ControlPlaneWorker"
          ip_pool                   = ""
          kubernetes_labels         = []
          kubernetes_version_policy = "default"
          vm_infra_config_policy    = "default"
          vm_instance_type_policy   = "default"
        }
      }
      nodeos_configuration_policy   = "default"
      tags                          = []
      trusted_certificate_authority = ""
      wait_for_completion           = false
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Cluster Profile Variable Map.
  * action - Action to perform on the Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * addons_policies - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor|kubernetes-dashboard} or [].
  * cluster_configuration - IKS Cluster Settings:
    - kubernetes_api_vip - VIP for the cluster Kubernetes API server. If this is empty and a cluster IP pool is specified, it will be allocated from the IP pool.
    - load_balancer_count - Number of load balancer addresses to deploy. Range is 1-999.
    - ssh_public_key - The SSH Public Key should be ssh_public_key_{1|2|3|4|5}.  This will point to the ssh_public_key variable that will be used.
    - ssh_user - SSH Username for node login. (This is now a read-only attribute.)
  * container_runtime_policy - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.
  * description - A description for the policy.
  * ip_pool - Name of the IP Pool to assign to Cluster and Node Profiles.
  * network_cidr_policy - Name of the Kubneretes Network CIDR Policy to assign to Cluster.
  * node_pools -   This Map of Objects is for both Control Plane Nodes and Worker Nodes.
    - action - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
    - description - A description for the Policy.
    - desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.
    - ip_pool - Name of the IP Pool to assign to Cluster and Node Profiles.  If not Assigned it will assign the ip_pool assigned to the cluster.
    - kubernetes_cluster_policy - Name of the Kubernetes Cluster Profile.
    - kubernetes_labels - List of key/value Attributes to Assign to the control plane node configuration.
    - kubernetes_version_policy - Name of the Kubernetes Version Policy to assign to the Node Profiles.
    - max_size - Maximum number of nodes desired in this node pool.  Range is 1-128.
    - min_size - Minimum number of nodes desired in this node pool.  Range is 1-128.
    - node_type - The node type:
      * ControlPlane - Node will be marked as a control plane node.
      * ControlPlaneWorker - Node will be both a controle plane and a worker.
      * Worker - Node will be marked as a worker node.
    - vm_instance_type_policy - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.
    - vm_infra_config_policy - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.

  * nodeos_configuration_policy - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.
  * tags - tags - List of key/value Attributes to Assign to the Profile.
  * trusted_certificate_authority - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles
  * wait_for_completion - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.
  EOT
  type = map(object(
    {
      action                    = optional(string)
      addons_policies           = optional(set(string))
      certificate_configuration = bool
      cluster_configuration = list(object(
        {
          kubernetes_api_vip  = optional(string)
          load_balancer_count = optional(number)
          ssh_public_key      = optional(number)
          # ssh_user            = optional(string)
        }
      ))
      container_runtime_policy = optional(string)
      description              = optional(string)
      ip_pool                  = string
      network_cidr_policy      = string
      node_pools = map(object(
        {
          action                    = optional(string)
          description               = optional(string)
          desired_size              = optional(number)
          ip_pool                   = optional(string)
          kubernetes_labels         = optional(list(map(string)))
          kubernetes_version_policy = string
          max_size                  = optional(number)
          min_size                  = optional(number)
          node_type                 = string
          vm_instance_type_policy   = string
          vm_infra_config_policy    = string
        }
      ))
      nodeos_configuration_policy   = string
      trusted_certificate_authority = optional(string)
      tags                          = optional(list(map(string)))
      wait_for_completion           = optional(bool)
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


#__________________________________________________________________________________________
#
# Kubernetes Cluster Profile
# GUI Location: Profiles > Kubernetes Cluster Profiles > Create Kubernetes Cluster Profile
#__________________________________________________________________________________________

resource "intersight_kubernetes_cluster_profile" "kubernetes_cluster_profiles" {
  for_each            = local.kubernetes_cluster_profiles
  action              = each.value.action
  description         = each.value.description != "" ? each.value.description : "${each.key} IKS Cluster."
  name                = each.key
  wait_for_completion = each.value.wait_for_completion
  cluster_ip_pools {
    moid = local.ip_pools[each.value.ip_pool]
  }
  dynamic "management_config" {
    for_each = each.value.cluster_configuration
    content {
      load_balancer_count = management_config.value.load_balancer_count
      master_vip          = management_config.value.kubernetes_api_vip
      ssh_keys = length(
        regexall("1", management_config.value.ssh_public_key)) > 0 ? [var.ssh_public_key_1] : length(
        regexall("2", management_config.value.ssh_public_key)) > 0 ? [var.ssh_public_key_2] : length(
        regexall("3", management_config.value.ssh_public_key)) > 0 ? [var.ssh_public_key_3] : length(
        regexall("4", management_config.value.ssh_public_key)) > 0 ? [var.ssh_public_key_4] : length(
        regexall("5", management_config.value.ssh_public_key)
      ) > 0 ? [var.ssh_public_key_5] : ""
      # ssh_user = management_config.value.ssh_user
    }
  }
  net_config {
    moid = local.network_cidr_policies[each.value.network_cidr_policy]
  }
  organization {
    moid        = local.org_moid
    object_type = "organization.Organization"
  }
  sys_config {
    moid = local.nodeos_configuration_policies[each.value.nodeos_configuration_policy]
  }
  dynamic "cert_config" {
    for_each = each.value.certificate_configuration == true ? each.value.cluster_configuration : []
    content {
      ca_cert             = var.api_server_certificate
      ca_key              = var.api_server_key
      etcd_cert           = var.etcd_certificate
      etcd_encryption_key = var.etcd_encryption_key
      etcd_key            = var.etcd_key
      front_proxy_cert    = var.front_proxy_certificate
      front_proxy_key     = var.front_proxy_key
      sa_private_key      = var.service_account_private_key
      sa_public_key       = var.service_account_public_key
    }
  }
  dynamic "container_runtime_config" {
    for_each = length(compact([each.value.container_runtime_policy])) > 0 ? toset(
      [each.value.container_runtime_policy]
    ) : []
    content {
      moid = local.container_runtime_policies[container_runtime_config.value]
    }
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
  dynamic "trusted_registries" {
    for_each = length(compact([each.value.trusted_certificate_authority])) > 0 ? toset(
      [each.value.trusted_certificate_authority]
    ) : []
    content {
      moid = trusted_registries.value
    }
  }
}

#__________________________________________________________________________________________
#
# Kubernetes Cluster - Add-ons
# GUI Location: Profiles > Kubernetes Cluster Profiles > Create Kubernetes Cluster Profile
#__________________________________________________________________________________________

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

resource "intersight_kubernetes_cluster_addon_profile" "cluster_addon" {
  depends_on = [
    intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles
  ]
  for_each = local.kubernetes_cluster_profiles
  name     = each.key
  associated_cluster {
    moid = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[each.key].associated_cluster[0].moid
  }
  organization {
    moid        = local.org_moid
    object_type = "organization.Organization"
  }
  dynamic "addons" {
    for_each = toset(each.value.addons_policies)
    content {
      addon_policy {
        moid = local.addons_policies["${addons.value}"].moid
      }
      name = local.addons_policies["${addons.value}"].name
    }
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


#______________________________________________
#
# Create the Control Plane Profile
#______________________________________________

#__________________________________________________________________________________________
#
# Intersight Kubernetes - Node Group Profiles
# GUI Location: Profiles > Kubernetes Cluster Profiles > Create Kubernetes Cluster Profile
#__________________________________________________________________________________________

resource "intersight_kubernetes_node_group_profile" "kubernetes_node_pools" {
  depends_on = [
    intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles
  ]
  for_each    = local.kubernetes_node_pools
  action      = each.value.action
  description = each.value.description
  name        = each.key
  node_type   = each.value.node_type
  desiredsize = each.value.desired_size
  minsize     = each.value.min_size
  maxsize     = each.value.max_size
  ip_pools {
    moid        = local.ip_pools[each.value.ip_pool]
    object_type = "ippool.Pool"
  }
  kubernetes_version {
    moid        = local.kubernetes_version_policies[each.value.kubernetes_version_policy]
    object_type = "kubernetes.VersionPolicy"
  }

  cluster_profile {
    moid        = intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles[each.value.kubernetes_cluster_profile].moid
    object_type = "kubernetes.ClusterProfile"
  }
  dynamic "labels" {
    for_each = each.value.kubernetes_labels
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


#____________________________________________________________
#
# Intersight Kubernetes Virtual Machine Infrastructure Provider
# GUI Location: Policies > Create Policy
#____________________________________________________________

resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "k8s_vm_infra_provider" {
  depends_on = [
    intersight_kubernetes_node_group_profile.kubernetes_node_pools
  ]
  for_each    = local.kubernetes_node_pools
  description = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Virtual machine Infrastructure Provider"
  name        = each.key
  infra_config_policy {
    moid = local.virtual_machine_infra_config[each.value.vm_infra_config_policy]
  }
  instance_type {
    moid = local.virtual_machine_instance_type[each.value.vm_instance_type_policy]
  }
  node_group {
    moid = intersight_kubernetes_node_group_profile.kubernetes_node_pools[each.key].moid
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
