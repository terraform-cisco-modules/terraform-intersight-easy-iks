locals {
  # Intersight Organization Variables
  org_name = var.organization
  ip_pools = {
    for k, v in var.ip_pools : k => {
      from    = (v.from != null ? v.from : 20)
      gateway = (v.gateway != null ? v.gateway : "198.18.0.1/24")
      name    = (v.name != null ? v.name : "")
      size    = (v.size != null ? v.size : 30)
      tags    = (v.tags != null ? v.tags : [])
    }
  }
  k8s_addons = {
    for k, v in var.k8s_addons : k => {
      install_strategy = (v.install_strategy != null ? v.install_strategy : "Always")
      name             = (v.name != null ? v.name : "")
      release_name     = (v.release_name != null ? v.release_name : "")
      tags             = (v.tags != null ? v.tags : [])
      upgrade_strategy = (v.upgrade_strategy != null ? v.upgrade_strategy : "UpgradeOnly")
    }
  }
  k8s_runtime = {
    for k, v in var.k8s_runtime : k => {
      docker_bridge_cidr = (v.docker_bridge_cidr != null ? v.docker_bridge_cidr : "")
      docker_no_proxy    = (v.docker_no_proxy != null ? v.docker_no_proxy : [])
      http_hostname      = (v.http_hostname != null ? v.http_hostname : "")
      http_port          = (v.http_port != null ? v.http_port : 8080)
      http_protocol      = (v.http_protocol != null ? v.http_protocol : "http")
      http_username      = (v.http_username != null ? v.http_username : "")
      https_hostname     = (v.https_hostname != null ? v.https_hostname : "")
      https_port         = (v.https_port != null ? v.https_port : 8443)
      https_protocol     = (v.https_protocol != null ? v.https_protocol : "https")
      https_username     = (v.https_username != null ? v.https_username : "")
      name               = (v.name != null ? v.name : "")
      tags               = (v.tags != null ? v.tags : [])
    }
  }
  k8s_trusted_registry = {
    for k, v in var.k8s_trusted_registry : k => {
      name     = (v.name != null ? v.name : "")
      root_ca  = (v.root_ca != null ? v.root_ca : [])
      tags     = (v.tags != null ? v.tags : [])
      unsigned = (v.unsigned != null ? v.unsigned : [])
    }
  }
  k8s_version = {
    for k, v in var.k8s_version : k => {
      name    = (v.name != null ? v.name : "")
      tags    = (v.tags != null ? v.tags : [])
      version = (v.version != null ? v.version : "1.19.5")
    }
  }
  k8s_vm_infra = {
    for k, v in var.k8s_vm_infra : k => {
      name                  = (v.name != null ? v.name : "")
      tags                  = (v.tags != null ? v.tags : [])
      vsphere_cluster       = coalesce(v.vsphere_cluster, "default")
      vsphere_datastore     = coalesce(v.vsphere_datastore, "datastore1")
      vsphere_portgroup     = coalesce(v.vsphere_portgroup, ["VM Network"])
      vsphere_resource_pool = (v.vsphere_resource_pool != null ? v.vsphere_resource_pool : "")
      vsphere_target        = coalesce(v.vsphere_target, "")
    }
  }
  k8s_vm_instance = {
    for k, v in var.k8s_vm_instance : k => {
      cpu    = (v.cpu != null ? v.cpu : 4)
      disk   = (v.disk != null ? v.disk : 40)
      memory = (v.memory != null ? v.memory : 16384)
      tags   = (v.tags != null ? v.tags : [])
    }
  }
  k8s_vm_network = {
    for k, v in var.k8s_vm_network : k => {
      cidr_pod     = (v.cidr_pod != null ? v.cidr_pod : "100.64.0.0/16")
      cidr_service = (v.cidr_service != null ? v.cidr_service : "100.65.0.0/16")
      cni          = (v.cni != null ? v.cni : "Calico")
      name         = (v.name != null ? v.name : "")
      tags         = (v.tags != null ? v.tags : [])
    }
  }
  # IKS Cluster Variables
  iks_cluster = {
    for k, v in var.iks_cluster : k => {
      action_cluster             = (v.action_cluster != null ? v.action_cluster : "Deploy")
      action_control_plane       = (v.action_control_plane != null ? v.action_control_plane : "No-op")
      action_worker              = (v.action_worker != null ? v.action_worker : "No-op")
      addons                     = (v.addons != null ? v.addons : [])
      control_plane_desired_size = (v.control_plane_desired_size != null ? v.control_plane_desired_size : 1)
      control_plane_intance_moid = v.control_plane_intance_moid
      control_plane_max_size     = (v.control_plane_max_size != null ? v.control_plane_max_size : 3)
      ip_pool_moid               = v.ip_pool_moid
      k8s_vm_infra_moid          = v.k8s_vm_infra_moid
      load_balancers             = (v.load_balancers != null ? v.load_balancers : 3)
      ssh_key                    = v.ssh_key
      ssh_user                   = (v.ssh_user != null ? v.ssh_user : "iksadmin")
      registry_moid              = (v.registry_moid != null ? v.registry_moid : "")
      runtime_moid               = (v.runtime_moid != null ? v.runtime_moid : [])
      tags                       = (v.tags != null ? v.tags : [])
      version_moid               = v.version_moid
      vm_network_moid            = v.vm_network_moid
      wait_for_complete          = (v.wait_for_complete != null ? v.wait_for_complete : false)
      worker_desired_size        = (v.worker_desired_size != null ? v.worker_desired_size : 1)
      worker_intance_moid        = v.worker_intance_moid
      worker_max_size            = (v.worker_max_size != null ? v.worker_max_size : 4)
    }
  }
}


#__________________________________________________________
#
# Required Variables
#__________________________________________________________

variable "tenant_name" {
  default     = "default"
  description = "Tenant Name for Workspace Creation in Terraform Cloud and IKS Cluster Naming."
  type        = string
}

variable "tags" {
  default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = list(map(string))
}

#______________________________________________
#
# DNS Variables
#______________________________________________

variable "domain_name" {
  default     = "example.com"
  description = "Domain Name for Kubernetes Sysconfig Policy."
  type        = string
}

variable "dns_servers_v4" {
  default     = ["198.18.0.100", "198.18.0.101"]
  description = "DNS Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}


#______________________________________________
#
# Time Variables
#______________________________________________

variable "ntp_servers" {
  default     = []
  description = "NTP Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}

variable "timezone" {
  default     = "Etc/GMT"
  description = "Timezone for Deployment.  For a List of supported timezones see the following URL.\r\n https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md."
  type        = string
}

#______________________________________________
#
# IP Pool Variables
#______________________________________________

variable "ip_pools" {
  default = {
    default = {
      from    = 20
      gateway = "198.18.0.1/24"
      name    = "{tenant_name}_ip_pool"
      size    = 30
      tags    = []
    }
  }
  description = "* from - host address of the pool starting address.  Default is 20\r\n* gateway - ip/prefix of the gateway.  Default is 198.18.0.1/24\r\n* name - Name of the IP Pool.  Default is {tenant}_{cluster_name}_ip_pool.\r\n* size - Number of host addresses to assign to the pool.  Default is 30."
  type = map(object(
    {
      from    = optional(number)
      gateway = optional(string)
      name    = optional(string)
      size    = optional(number)
      tags    = optional(list(map(string)))
    }
  ))
}

#__________________________________________________________
#
# Kubernetes Policy Variables
#__________________________________________________________

#______________________________________________
#
# Kubernetes Add-ons Policy Variables
#______________________________________________

variable "k8s_addons" {
  default = {
    default = {
      install_strategy = "Always"
      name             = "{tenant_name}_{addon_key}"
      release_name     = ""
      tags             = []
      upgrade_strategy = "UpgradeOnly"
    }
  }
  description = "Map of Add-ons for Intersight Kubernetes Service.  Add-ons Options are {ccp-monitor|kubernetes-dashboard}."
  type = map(object(
    {
      install_strategy = optional(string)
      name             = optional(string)
      release_name     = optional(string)
      tags             = optional(list(map(string)))
      upgrade_strategy = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Runtime Policy Variables
#______________________________________________

variable "k8s_runtime_create" {
  default     = false
  description = "Flag to specify if the Kubernetes Runtime Policy should be created or not."
  type        = bool
}

variable "k8s_runtime" {
  default = {
    default = {
      docker_bridge_cidr = ""
      docker_no_proxy    = []
      http_hostname      = ""
      http_port          = 8080
      http_protocol      = "http"
      http_username      = ""
      https_hostname     = ""
      https_port         = 8443
      https_protocol     = "https"
      https_username     = ""
      name               = ""
      tags               = []
    }
  }
  description = ""
  # description = "Docker no proxy list, when using internet proxy.  Default is no list."
  # description = "Proxy HTTP Port."
  # description = "Proxy HTTP Protocol."
  # description = "Password for the HTTP Proxy Server, If required."
  # description = "Password for the HTTPS Proxy Server, If required."
  # description = "Proxy HTTPS Port."
  # description = "Proxy HTTP Protocol."
  type = map(object(
    {
      docker_bridge_cidr = optional(string)
      docker_no_proxy    = optional(list(string))
      http_hostname      = optional(string)
      http_port          = optional(number)
      http_protocol      = optional(string)
      http_username      = optional(string)
      https_hostname     = optional(string)
      https_port         = optional(number)
      https_protocol     = optional(string)
      https_username     = optional(string)
      name               = optional(string)
      tags               = optional(list(map(string)))
    }
  ))
}

variable "k8s_runtime_http_password" {
  default     = ""
  description = "Password for the HTTP Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "k8s_runtime_https_password" {
  default     = ""
  description = "Password for the HTTPS Proxy Server, If required."
  sensitive   = true
  type        = string
}


#______________________________________________
#
# Kubernetes Trusted Registries Variables
#______________________________________________

variable "k8s_trusted_create" {
  default     = false
  description = "Flag to specify if the Kubernetes Runtime Policy should be created or not."
  type        = bool
}

variable "k8s_trusted_registry" {
  default = {
    default = {
      name     = ""
      root_ca  = []
      tags     = []
      unsigned = []
    }
  }
  # description = "Kubernetes Trusted Registry Policy Name.  Default is {tenant_name}_registry."
  # description = "List of root CA Signed Registries."
  # description = "List of unsigned registries to be supported."
  type = map(object(
    {
      name     = optional(string)
      root_ca  = optional(list(string))
      tags     = optional(list(map(string)))
      unsigned = optional(list(string))
    }
  ))
}

#______________________________________________
#
# Kubernetes Version Variables
#______________________________________________

variable "k8s_version" {
  default = {
    default = {
      name    = ""
      tags    = []
      version = "1.19.5"
    }
  }
  description = "Kubernetes Version to Deploy."
  # description = "Kubernetes Trusted Registry Policy Name.  Default is {tenant_name}_registry."
  type = map(object(
    {
      name    = optional(string)
      tags    = optional(list(map(string)))
      version = optional(string)
    }
  ))
}


#______________________________________________
#
# K8S VM Infra Policy Variables
#______________________________________________

# variable "vsphere_target" {
#   default     = "210"
#   description = "vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox."
#   type        = string
#   validation {
#     condition = (
#       can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.vsphere_target)) ||
#       can(regex("^[0-9]{1,3}$", var.vsphere_target)) ||
#       can(regex("^[[:alnum:]]+", var.vsphere_target))
#     )
#     error_message = "The vsphere_target must be in the format hostname or IPv4 Address or just a number."
#   }
# }
# output "vsphere_target" {
#   description = "vSphere Target."
#   value = trimspace(<<-EOT
#   %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.vsphere_target))}${var.vsphere_target}%{endif}
#   %{if can(regex("^[0-9]{1,3}$", var.vsphere_target))}${join(".", [var.network_prefix, var.vsphere_target])}%{endif}
#   %{if can(regex("^[[:alnum:]]+", var.vsphere_target))}${var.vsphere_target}%{endif}
#   EOT
#   )
# }


#______________________________________________
#
# Kubernetes Virtual Machine Infra Variables
#______________________________________________

variable "k8s_vm_infra" {
  default = {
    default = {
      name                  = ""
      tags                  = []
      vsphere_cluster       = "default"
      vsphere_datastore     = "datastore1"
      vsphere_portgroup     = ["VM Network"]
      vsphere_resource_pool = ""
      vsphere_target        = ""
    }
  }
  description = "Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {tenant_name}_vm_infra."
  # description = "vSphere Cluster to assign the K8S Cluster Deployment."
  # description = "vSphere Datastore to assign the K8S Cluster Deployment."
  # description = "vSphere Port Group to assign the K8S Cluster Deployment."
  # description = "vSphere Resource Pool to assign the K8S Cluster Deployment."
  type = map(object(
    {
      name                  = optional(string)
      tags                  = optional(list(map(string)))
      vsphere_cluster       = string
      vsphere_datastore     = string
      vsphere_portgroup     = list(string)
      vsphere_resource_pool = optional(string)
      vsphere_target        = string
    }
  ))
}

variable "k8s_vm_infra_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}


#______________________________________________
#
# Kubernetes Virtual Machine Instance Variables
#______________________________________________

variable "k8s_vm_instance" {
  default = {
    default = {
      cpu    = 4
      disk   = 40
      memory = 16384
      tags   = []
    }
  }
  description = "Kubernetes Virtual Machine Instance Policy Variables.  Default name is {tenant_name}_vm_network."
  type = map(object(
    {
      cpu    = optional(number)
      disk   = optional(number)
      memory = optional(number)
      tags   = optional(list(map(string)))
    }
  ))
}


#______________________________________________
#
# Kubernetes Virtual Machine Node OS Variables
#______________________________________________

variable "k8s_vm_network" {
  default = {
    default = {
      cidr_pod     = "100.64.0.0/16"
      cidr_service = "100.65.0.0/16"
      cni          = "Calico"
      name         = ""
      tags         = []
    }
  }
  description = "Kubernetes Virtual Machine Network Configuration Policy.  Default name is {tenant_name}_vm_network."
  # description = "Supported CNI type. Currently we only support Calico.\r\n* Calico - Calico CNI plugin as described in:\r\n https://github.com/projectcalico/cni-plugin."
  # description = "Pod CIDR Block to be used to assign Pod IP Addresses."
  # description = "Service CIDR Block used to assign Cluster Service IP Addresses."
  type = map(object(
    {
      cidr_pod     = optional(string)
      cidr_service = optional(string)
      cni          = optional(string)
      name         = optional(string)
      tags         = optional(list(map(string)))
    }
  ))
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
      action_cluster             = "Deploy"
      action_control_plane       = "No-op"
      action_worker              = "No-op"
      addons                     = []
      control_plane_desired_size = 1
      control_plane_intance_moid = "**REQUIRED**"
      control_plane_max_size     = 3
      ip_pool_moid               = "**REQUIRED**"
      k8s_vm_infra_moid          = "**REQUIRED**"
      load_balancers             = 3
      ssh_key                    = "ssh_key_1"
      ssh_user                   = "iksadmin"
      registry_moid              = ""
      runtime_moid               = []
      tags                       = []
      version_moid               = "**REQUIRED**"
      vm_network_moid            = "**REQUIRED**"
      wait_for_complete          = false
      worker_desired_size        = 0
      worker_intance_moid        = "**REQUIRED**"
      worker_max_size            = 4
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
      action_cluster             = optional(string)
      action_control_plane       = optional(string)
      action_worker              = optional(string)
      action                     = optional(string)
      addons                     = optional(set(string))
      control_plane_desired_size = optional(number)
      control_plane_intance_moid = string
      control_plane_max_size     = optional(number)
      ip_pool_moid               = string
      k8s_vm_infra_moid          = string
      load_balancers             = optional(number)
      ssh_key                    = string
      ssh_user                   = string
      registry_moid              = optional(string)
      runtime_moid               = optional(list(map(string)))
      tags                       = optional(list(map(string)))
      version_moid               = string
      vm_network_moid            = string
      wait_for_complete          = optional(bool)
      worker_desired_size        = optional(number)
      worker_intance_moid        = string
      worker_max_size            = optional(number)
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
  name              = "${var.tenant_name}_${each.key}"
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
  workspace_id = module.iks_workspaces["${each.key}"].workspace.id
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
    endpoint = {
      description = "Intersight API Key."
      key         = "endpoint"
      value       = var.endpoint
    },
    secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    },
    #---------------------------
    # K8S Policy Variables
    #---------------------------
    domain_name = {
      description = "Domain Name."
      key         = "domain_name"
      value       = var.domain_name
    },
    dns_servers = {
      description = "DNS Servers."
      hcl         = true
      key         = "dns_servers_v4"
      value       = "[${join(",", [for s in var.dns_servers_v4 : format("%q", s)])}]"
    },
    ntp_servers = {
      description = "NTP Servers."
      hcl         = true
      key         = "ntp_servers"
      value       = "[${join(",", [for s in var.ntp_servers : format("%q", s)])}]"
    },
    tenant_name = {
      description = "Tenant Name."
      key         = "tenant_name"
      value       = var.tenant_name
    },
    tags = {
      description = "Intersight Tags for Poliices and Profiles."
      hcl         = true
      key         = "tags"
      value       = "${jsonencode(var.tags)}"
    },
    timezone = {
      description = "Timezone."
      key         = "timezone"
      value       = var.timezone
    },
    ip_pools = {
      description = "${var.tenant_name} IP Pools."
      hcl         = true
      key         = "ip_pools"
      value       = "${jsonencode(var.ip_pools)}"
    },
    k8s_addons = {
      description = "${var.tenant_name} Addons Policies."
      hcl         = true
      key         = "k8s_addons"
      value       = "${jsonencode(var.k8s_addons)}"
    },
    k8s_runtime_create = {
      description = "${var.tenant_name} Kubernetes Runtime Policy Create Option."
      key         = "k8s_runtime_create"
      value       = var.k8s_runtime_create
    },
    k8s_runtime = {
      description = "${var.tenant_name} Kubernetes Runtime Policy Variables."
      hcl         = true
      key         = "k8s_runtime"
      value       = "${jsonencode(var.k8s_runtime)}"
    },
    k8s_trusted_create = {
      description = "${var.tenant_name} Kubernetes Trusted Registry Policy Create Option."
      key         = "k8s_trusted_create"
      value       = var.k8s_trusted_create
    },
    k8s_trusted_registry = {
      description = "${var.tenant_name} Kubernetes Trusted Registry Policy Variables."
      hcl         = true
      key         = "k8s_trusted_registry"
      value       = "${jsonencode(var.k8s_trusted_registry)}"
    },
    k8s_version = {
      description = "${var.tenant_name} Kubernetes Version Policy Variables."
      hcl         = true
      key         = "k8s_version"
      value       = "${jsonencode(var.k8s_version)}"
    },
    k8s_vm_infra = {
      description = "${var.tenant_name} Kubernetes VIrtual Machine Infra Config Policy Variables."
      hcl         = true
      key         = "k8s_vm_infra"
      value       = "${jsonencode(var.k8s_vm_infra)}"
    },
    k8s_vm_instance = {
      description = "${var.tenant_name} Kubernetes Virtual Machine Instance Policy Variables."
      hcl         = true
      key         = "k8s_vm_instance"
      value       = "${jsonencode(var.k8s_vm_instance)}"
    },
    k8s_vm_network = {
      description = "${var.tenant_name} Kubernetes Virtual Machine Network Config Policy Variables."
      hcl         = true
      key         = "k8s_vm_network"
      value       = "${jsonencode(var.k8s_vm_network)}"
    },
    #---------------------------
    # IKS Cluster Variables
    #---------------------------
    iks_cluster = {
      description = "${var.tenant_name} IKS Clusters."
      hcl         = true
      key         = "iks_cluster"
      value       = "${jsonencode(var.iks_cluster)}"
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
