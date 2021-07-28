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
    }
  }
  description = "Intersight Kubernetes Service Cluster Profile Variable Map.\r\n1. action_cluster - Action to perform on the Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}.\r\n2. action_control_plane - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.\r\n3. action_worker - Action to perform on the Kubernetes Worker Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.\r\n4. control_plane_desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.\r\n5. control_plane_k8s_labels - List of key/value Attributes to Assign to the control plane node configuration.\r\n6. control_plane_max_size - Maximum number of control plane nodes desired in this node group.  Range is 1-128.\r\n7. description - A description for the policy.\r\n8. ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.\r\n9. k8s_addon_policy_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor|kubernetes-dashboard} or [].\r\n10. k8s_network_cidr_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.\r\n11. k8s_nodeos_config_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.\r\n12. k8s_registry_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles\r\n.13. k8s_runtime_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles\r\n.14. k8s_version_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.\r\n15. k8s_vm_infra_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.\r\n16. k8s_vm_instance_type_ctrl_plane - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.\r\n17. k8s_vm_instance_type_worker - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to worker nodes.\r\n18. load_balancers - Number of load balancer addresses to deploy. Range is 1-999.\r\n19. organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/ \r\n20. ssh_key - The SSH Key Name should be ssh_key_{1|2|3|4|5}.  This will point to the ssh_key variable that will be used.\r\n21. ssh_user - SSH Username for node login.\r\n22. tags - tags - List of key/value Attributes to Assign to the Profile.\r\n23. wait_for_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.\r\n24. worker_desired_size - Desired number of nodes in this worker node group, same as minsize initially and is updated by the auto-scaler.  Range is 1-128.\r\n25. worker_k8s_labels - List of key/value Attributes to Assign to the worker node configuration.\r\n26. worker_max_size - Maximum number of worker nodes desired in this node group.  Range is 1-128.\r\n"
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


#__________________________________________________________
#
# Terraform Cloud {organization}_{iks_cluster} Workspaces
#__________________________________________________________

module "iks_workspaces" {
  source            = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each          = local.iks_cluster
  auto_apply        = true
  description       = "${each.key} Workspace."
  name              = each.key
  terraform_version = var.terraform_version
  tfc_oauth_token   = var.tfc_oauth_token
  tfc_org_name      = var.tfc_organization
  vcs_repo          = var.vcs_repo
  working_directory = "modules/iks"
}

output "iks_workspaces" {
  description = "Terraform Cloud IKS Workspace ID(s)."
  value       = { for v in sort(keys(module.iks_workspaces)) : v => module.iks_workspaces[v].workspace.id }
}

#__________________________________________________________
#
# Terraform Cloud Workspace Variables: iks
#__________________________________________________________

module "iks_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.iks_workspaces
  ]
  category     = "terraform"
  for_each     = local.iks_cluster
  workspace_id = module.iks_workspaces[each.key].workspace.id
  variable_list = {
    #---------------------------
    # Terraform Cloud Variables
    #---------------------------
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    #---------------------------
    # Intersight Variables
    #---------------------------
    apikey = {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    },
    #---------------------------
    # IKS Cluster Variables
    #---------------------------
    iks_cluster = {
      description = "${each.key} IKS Cluster."
      hcl         = false
      key         = "iks_cluster"
      value       = "{ \"${each.key}\": ${jsonencode(local.iks_cluster[each.key])} }"
    },
    ssh_key_1 = {
      description = "SSH Key Variable 1."
      key         = "ssh_key_1"
      sensitive   = true
      value       = var.ssh_key_1
    },
    ssh_key_2 = {
      description = "SSH Key Variable 2."
      key         = "ssh_key_2"
      sensitive   = true
      value       = var.ssh_key_2
    },
    ssh_key_3 = {
      description = "SSH Key Variable 3."
      key         = "ssh_key_3"
      sensitive   = true
      value       = var.ssh_key_3
    },
    ssh_key_4 = {
      description = "SSH Key Variable 4."
      key         = "ssh_key_4"
      sensitive   = true
      value       = var.ssh_key_4
    },
    ssh_key_5 = {
      description = "SSH Key Variable 5."
      key         = "ssh_key_5"
      sensitive   = true
      value       = var.ssh_key_5
    },
  }
}
