
locals {
  # IKS Cluster Variables
  iks_cluster = {
    for k, v in var.iks_cluster : k => {
      action                     = (v.action != null ? v.action : "Deploy")
      cluster_moid               = v.cluster_moid
      control_plane_desired_size = (v.control_plane_desired_size != null ? v.control_plane_desired_size : 1)
      control_plane_intance_moid = v.control_plane_intance_moid
      control_plane_max_size     = (v.control_plane_max_size != null ? v.control_plane_max_size : 3)
      control_plane_profile_moid = v.control_plane_profile_moid
      ip_pool_moid               = v.ip_pool_moid
      k8s_vm_infra_moid          = v.k8s_vm_infra_moid
      load_balancers             = (v.load_balancers != null ? v.load_balancers : 3)
      cluster_name               = v.cluster_name
      network_cidr_moid          = v.network_cidr_moid
      nodeos_cfg_moid            = v.nodeos_cfg_moid
      ssh_key                    = v.ssh_key
      ssh_user                   = (v.ssh_user != null ? v.ssh_user : "iksadmin")
      registry_moid              = (v.registry_moid != null ? v.registry_moid : "")
      runtime_moid               = (v.runtime_moid != null ? v.runtime_moid : "")
      tags                       = (v.tags != null ? v.tags : [])
      version_moid               = v.version_moid
      wait_for_complete          = (v.wait_for_complete   != null ? v.wait_for_complete   : false)
      worker_desired_size        = (v.worker_desired_size != null ? v.worker_desired_size : 1)
      worker_intance_moid        = v.worker_intance_moid
      worker_max_size            = (v.worker_max_size != null ? v.worker_max_size : 4)
      worker_profile_moid        = v.worker_profile_moid
    }
  }
}

#______________________________________________
#
# Tenant Variables
#______________________________________________

variable "ws_tenant" {
  default     = "default"
  description = "Name of the Tenant Workspace."
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

variable "iks_cluster" {
  default = {
    default = {
      action                     = "Deploy"
      cluster_moid               = "**REQUIRED**"
      control_plane_desired_size = 1
      control_plane_intance_moid = "**REQUIRED**"
      control_plane_max_size     = 3
      control_plane_profile_moid = "**REQUIRED**"
      ip_pool_moid               = "**REQUIRED**"
      k8s_vm_infra_moid          = "**REQUIRED**"
      load_balancers             = 3
      cluster_name               = "**REQUIRED**"
      network_cidr_moid          = "**REQUIRED**"
      nodeos_cfg_moid            = "**REQUIRED**"
      ssh_key                    = "ssh_key_1"
      ssh_user                   = "iksadmin"
      registry_moid              = ""
      runtime_moid               = ""
      tags                       = []
      version_moid               = "**REQUIRED**"
      wait_for_complete          = false
      worker_desired_size        = 0
      worker_intance_moid        = "**REQUIRED**"
      worker_max_size            = 4
      worker_profile_moid        = "**REQUIRED**"
    }
  }
  description = "Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}."
  # description = "Intersight Kubernetes Load Balancer count."
  # description = "Intersight Kubernetes Service Cluster Default User."
  # description = "Intersight Kubernetes Service Cluster SSH Public Key."
  # description = "K8S Control Plane Virtual Machine Instance Type moid."
  # description = "K8S Control Plane Desired Cluster Size."
  # description = "K8S Control Plane Maximum Cluster Size."
  # description = "K8S Worker Virtual Machine Instance Type moid."
  # description = "K8S Worker Desired Cluster Size."
  # description = "K8S Worker Maximum Cluster Size."
  type = map(object(
    {
      action                     = optional(string)
      cluster_moid               = string
      control_plane_desired_size = optional(number)
      control_plane_intance_moid = string
      control_plane_max_size     = optional(number)
      control_plane_profile_moid = string
      ip_pool_moid               = string
      k8s_vm_infra_moid          = string
      load_balancers             = optional(number)
      cluster_name               = string
      network_cidr_moid          = string
      nodeos_cfg_moid            = string
      ssh_key                    = string
      ssh_user                   = string
      registry_moid              = optional(string)
      runtime_moid               = optional(string)
      tags                       = optional(list(map(string)))
      version_moid               = string
      wait_for_complete          = optional(bool)
      worker_desired_size        = optional(number)
      worker_intance_moid        = string
      worker_max_size            = optional(number)
      worker_profile_moid        = string
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
  description = "Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_3" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_4" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_5" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

#__________________________________________________________
#
# Terraform Cloud Workspaces
#__________________________________________________________

module "iks_workspaces" {
  source            = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each          = var.iks_cluster
  auto_apply        = true
  description       = "Intersight Kubernetes Service Workspace."
  name              = "${var.tenant_name}_${each.value.cluster_name}"
  terraform_version = var.terraform_version
  tfc_oath_token    = var.tfc_oath_token
  tfc_org_name      = var.tfc_organization
  vcs_repo          = var.vcs_repo
  working_directory = "iks"
}

output "iks_workspaces" {
  description = "Terraform Cloud IKS Workspace ID(s)."
  value       = { for v in sort(keys(module.iks_workspaces)) : v => module.iks_workspaces[v] }
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
  for_each     = var.iks_cluster
  category     = "terraform"
  workspace_id = module.iks_workspaces["${each.value.cluster_name}"].workspace.id
  variable_list = {
    #---------------------------
    # Terraform Cloud Variables
    #---------------------------
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    tenant_name = {
      description = "${var.tenant_name} Workspace."
      key         = "ws_tenant"
      value       = var.tenant_name
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
    ip_pools = {
      description = "${var.tenant_name} IP Pools."
      hcl         = true
      key         = "ip_pools"
      value       = "${jsonencode(var.ip_pools)}"
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
