#__________________________________________________________
#
# Intersight Kubernetes Service Cluster Variables
#__________________________________________________________

#______________________________________________
#
# IKS Cluster Variables
#______________________________________________

variable "iks_cluster" {
  default = {
    default = {
      action_cluster                  = "Deploy"
      action_control_plane            = "No-op"
      action_worker                   = "No-op"
      control_plane_desired_size      = 1
      control_plane_k8s_labels        = []
      control_plane_max_size          = 3
      description                     = ""
      ip_pool_moid                    = "**REQUIRED**"
      k8s_addon_policy_moid           = []
      k8s_network_cidr_moid           = "**REQUIRED**"
      k8s_nodeos_config_moid          = "**REQUIRED**"
      k8s_registry_moid               = ""
      k8s_runtime_moid                = ""
      k8s_version_moid                = "**REQUIRED**"
      k8s_vm_infra_moid               = "**REQUIRED**"
      k8s_vm_instance_type_ctrl_plane = "**REQUIRED**"
      k8s_vm_instance_type_worker     = "**REQUIRED**"
      load_balancers                  = 3
      organization                    = "default"
      ssh_key                         = "ssh_key_1"
      ssh_user                        = "iksadmin"
      tags                            = []
      wait_for_complete               = false
      worker_desired_size             = 0
      worker_k8s_labels               = []
      worker_max_size                 = 4
      workspace_name                  = "**REQURIED**"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Cluster Profile Variable Map.
  * action_cluster - Action to perform on the Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * action_control_plane - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * action_worker - Action to perform on the Kubernetes Worker Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * control_plane_desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.
  * control_plane_k8s_labels - List of key/value Attributes to Assign to the control plane node configuration.
  * control_plane_max_size - Maximum number of control plane nodes desired in this node group.  Range is 1-128.
  * description - A description for the policy.
  * ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.
  * k8s_addon_policy_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor|kubernetes-dashboard} or [].
  * k8s_network_cidr_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.
  * k8s_nodeos_config_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.
  * k8s_registry_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles
  * k8s_runtime_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.
  * k8s_version_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.
  * k8s_vm_infra_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.
  * k8s_vm_instance_type_ctrl_plane - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.
  * k8s_vm_instance_type_worker - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to worker nodes.
  * load_balancers - Number of load balancer addresses to deploy. Range is 1-999.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * ssh_key - The SSH Key Name should be ssh_key_{1|2|3|4|5}.  This will point to the ssh_key variable that will be used.
  * ssh_user - SSH Username for node login.
  * tags - tags - List of key/value Attributes to Assign to the Profile.
  * wait_for_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.
  * worker_desired_size - Desired number of nodes in this worker node group, same as minsize initially and is updated by the auto-scaler.  Range is 1-128.
  * worker_k8s_labels - List of key/value Attributes to Assign to the worker node configuration.
  * worker_max_size - Maximum number of worker nodes desired in this node group.  Range is 1-128.
  * workspace_name - Name of the Terraform Cloud Workspace the IKS Cluster should be assigned to.
  EOT
  type = map(object(
    {
      action_cluster                  = optional(string)
      action_control_plane            = optional(string)
      action_worker                   = optional(string)
      control_plane_desired_size      = optional(number)
      control_plane_k8s_labels        = optional(list(map(string)))
      control_plane_max_size          = optional(number)
      description                     = optional(string)
      ip_pool_moid                    = string
      k8s_addon_policy_moid           = optional(set(string))
      k8s_network_cidr_moid           = string
      k8s_nodeos_config_moid          = string
      k8s_registry_moid               = optional(string)
      k8s_runtime_moid                = optional(string)
      k8s_version_moid                = string
      k8s_vm_infra_moid               = string
      k8s_vm_instance_type_ctrl_plane = string
      k8s_vm_instance_type_worker     = string
      load_balancers                  = optional(number)
      organization                    = optional(string)
      ssh_key                         = string
      ssh_user                        = string
      tags                            = optional(list(map(string)))
      wait_for_complete               = optional(bool)
      worker_desired_size             = optional(number)
      worker_k8s_labels               = optional(list(map(string)))
      worker_max_size                 = optional(number)
      workspace_name                  = string
    }
  ))
}

variable "ssh_key_1" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 1."
  sensitive   = true
  type        = string
}

variable "ssh_key_2" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_3" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_4" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_5" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}
