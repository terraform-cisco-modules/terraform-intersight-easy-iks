terraform {
  experiments = [module_variable_optional_attrs]
}

#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

variable "tfc_organization" {
  description = "Terraform Cloud Organization Name."
  type        = string
}

variable "tfc_workspace" {
  default     = "kubernetes_policies"
  description = "Name of the Kubernetes Policies workspace."
  type        = string
}


#__________________________________________________________
#
# Intersight Provider Variables
#__________________________________________________________

variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "secretkey" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}


#__________________________________________________________
#
# Intersight Kubernetes Service Cluster Variables
#__________________________________________________________

#______________________________________________
#
# IKS Cluster Variables
#______________________________________________

variable "kubernetes_cluster_profiles" {
  description = "Please Refer to the kubernetes_cluster_profiles variable information in the tfe module.  In the iks module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals."
  type        = string
}

variable "kubernetes_cluster_profiles" {
  default = {
    default = {
      action_cluster                     = "Deploy"
      action_control_plane               = "No-op"
      action_worker                      = "No-op"
      addons_policy_moid                 = []
      container_runtime_moid             = ""
      control_plane_desired_size         = 1
      control_plane_k8s_labels           = []
      control_plane_max_size             = 3
      control_plane_vm_instance_type     = "**REQUIRED**"
      description                        = ""
      ip_pool_moid                       = "**REQUIRED**"
      network_cidr_moid                  = "**REQUIRED**"
      nodeos_config_moid                 = "**REQUIRED**"
      kubernetes_version_moid            = "**REQUIRED**"
      load_balancers                     = 3
      organization                       = "default"
      ssh_key                            = "ssh_key_1"
      ssh_user                           = "iksadmin"
      tags                               = []
      trusted_certificate_authority_moid = ""
      virtual_machine_infra_config_moid  = "**REQUIRED**"
      wait_for_complete                  = false
      worker_desired_size                = 0
      worker_k8s_labels                  = []
      worker_max_size                    = 4
      worker_vm_instance_type_moid       = "**REQUIRED**"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Cluster Profile Variable Map.
  * action_cluster - Action to perform on the Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * action_control_plane - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * action_worker - Action to perform on the Kubernetes Worker Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.
  * addons_policy_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor|kubernetes-dashboard} or [].
  * container_runtime_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.
  * control_plane_desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.
  * control_plane_k8s_labels - List of key/value Attributes to Assign to the control plane node configuration.
  * control_plane_max_size - Maximum number of control plane nodes desired in this node group.  Range is 1-128.
  * control_plane_vm_instance_type - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.
  * description - A description for the policy.
  * ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.
  * kubernetes_version_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.
  * network_cidr_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.
  * nodeos_config_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.
  * load_balancers - Number of load balancer addresses to deploy. Range is 1-999.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * ssh_key - The SSH Key Name should be ssh_key_{1|2|3|4|5}.  This will point to the ssh_key variable that will be used.
  * ssh_user - SSH Username for node login.
  * tags - tags - List of key/value Attributes to Assign to the Profile.
  * trusted_certificate_authority_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles
  * virtual_machine_infra_config_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.
  * wait_for_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.
  * worker_desired_size - Desired number of nodes in this worker node group, same as minsize initially and is updated by the auto-scaler.  Range is 1-128.
  * worker_k8s_labels - List of key/value Attributes to Assign to the worker node configuration.
  * worker_max_size - Maximum number of worker nodes desired in this node group.  Range is 1-128.
  * worker_vm_instance_type_moid - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to worker nodes.
  EOT
  type = map(object(
    {
      action_cluster                     = optional(string)
      action_control_plane               = optional(string)
      action_worker                      = optional(string)
      addons_policy_moid                 = optional(set(string))
      container_runtime_moid             = optional(string)
      control_plane_desired_size         = optional(number)
      control_plane_k8s_labels           = optional(list(map(string)))
      control_plane_max_size             = optional(number)
      control_plane_vm_instance_type     = string
      description                        = optional(string)
      ip_pool_moid                       = string
      network_cidr_moid                  = string
      nodeos_config_moid                 = string
      trusted_certificate_authority_moid = optional(string)
      kubernetes_version_moid            = string
      virtual_machine_infra_config_moid  = string
      load_balancers                     = optional(number)
      organization                       = optional(string)
      ssh_key                            = string
      ssh_user                           = string
      tags                               = optional(list(map(string)))
      wait_for_complete                  = optional(bool)
      worker_desired_size                = optional(number)
      worker_k8s_labels                  = optional(list(map(string)))
      worker_max_size                    = optional(number)
      worker_vm_instance_type_moid       = string
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
