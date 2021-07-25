locals {
  # Policy Local Variables
  ip_pools = {
    for k, v in var.ip_pools : k => {
      from    = (v.from    != null ? v.from    : 20)
      gateway = (v.gateway != null ? v.gateway : "198.18.0.1/24")
      name    = (v.name    != null ? v.name    : "")
      size    = (v.size    != null ? v.size    : 30)
      tags    = (v.tags    != null ? v.tags    : [])
    }
  }
  k8s_runtime = {
    for k, v in var.k8s_runtime : k => {
      docker_bridge_cidr = (v.docker_bridge_cidr != null ? v.docker_bridge_cidr : "")
      docker_no_proxy    = (v.docker_no_proxy    != null ? v.docker_no_proxy    : [])
      http_hostname      = (v.http_hostname      != null ? v.http_hostname      : "")
      http_port          = (v.http_port          != null ? v.http_port          : 8080)
      http_protocol      = (v.http_protocol      != null ? v.http_protocol      : "http")
      http_username      = (v.http_username      != null ? v.http_username      : "")
      https_hostname     = (v.https_hostname     != null ? v.https_hostname     : "")
      https_port         = (v.https_port         != null ? v.https_port         : 8443)
      https_protocol     = (v.https_protocol     != null ? v.https_protocol     : "https")
      https_username     = (v.https_username     != null ? v.https_username     : "")
      name               = (v.name               != null ? v.name               : "")
      tags               = (v.tags               != null ? v.tags               : [])
    }
  }
  k8s_trusted_registry = {
    for k, v in var.k8s_trusted_registry : k => {
      name     = (v.name     != null ? v.name     : "")
      root_ca  = (v.root_ca  != null ? v.root_ca  : [])
      tags     = (v.tags     != null ? v.tags     : [])
      unsigned = (v.unsigned != null ? v.unsigned : [])
    }
  }
  k8s_version = {
    for k, v in var.k8s_version : k => {
      name    = (v.name    != null ? v.name    : "")
      tags    = (v.tags    != null ? v.tags    : [])
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
      large_cpu     = (v.large_cpu     != null ? v.large_cpu     : 12)
      large_disk    = (v.large_disk    != null ? v.large_disk    : 80)
      large_memory  = (v.large_memory  != null ? v.large_memory  : 32768)
      medium_cpu    = (v.medium_cpu    != null ? v.medium_cpu    : 8)
      medium_disk   = (v.medium_disk   != null ? v.medium_disk   : 60)
      medium_memory = (v.medium_memory != null ? v.medium_memory : 24576)
      small_cpu     = (v.small_cpu     != null ? v.small_cpu     : 4)
      small_disk    = (v.small_disk    != null ? v.small_disk    : 40)
      small_memory  = (v.small_memory  != null ? v.small_memory  : 16384)
      tags          = (v.tags          != null ? v.tags          : [])
    }
  }
  k8s_vm_network = {
    for k, v in var.k8s_vm_network : k => {
      cidr_pod     = (v.cidr_pod     != null ? v.cidr_pod     : "100.64.0.0/16")
      cidr_service = (v.cidr_service != null ? v.cidr_service : "100.65.0.0/16")
      cni          = (v.cni          != null ? v.cni          : "Calico")
      name         = (v.name         != null ? v.name         : "")
      tags         = (v.tags         != null ? v.tags         : [])
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
  default     = []
  description = "List of Add-ons for Intersight Kubernetes Service.  Add-ons Options are {ccp-monitor|kubernetes-dashboard}."
  type        = list(string)
}

variable "k8s_addons_name" {
  default     = ""
  description = "Kubernetes Addon Policy Name Prefix.  Default name is {tenant_name}."
  type        = string
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
      large_cpu     = 12
      large_disk    = 80
      large_memory  = 32768
      medium_cpu    = 8
      medium_disk   = 60
      medium_memory = 24576
      small_cpu     = 4
      small_disk    = 40
      small_memory  = 16384
      tags          = []
    }
  }
  description = "Kubernetes Virtual Machine Instance Policy Variables.  Default name is {tenant_name}_vm_network."
  type = map(object(
    {
      large_cpu     = optional(number)
      large_disk    = optional(number)
      large_memory  = optional(number)
      medium_cpu    = optional(number)
      medium_disk   = optional(number)
      medium_memory = optional(number)
      small_cpu     = optional(number)
      small_disk    = optional(number)
      small_memory  = optional(number)
      tags          = optional(list(map(string)))
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
# Terraform Cloud Workspace: {tenant_name}
#__________________________________________________________

module "tenant_workspace" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  depends_on = [
    module.tfc_agent_pool
  ]
  auto_apply          = true
  description         = "${var.tenant_name} Workspace."
  global_remote_state = true
  name                = var.tenant_name
  terraform_version   = var.terraform_version
  tfc_oath_token      = var.tfc_oath_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "tenant"
}

output "tenant_workspace" {
  description = "Terraform Cloud Tenant Workspace ID."
  value       = module.tenant_workspace
}

#__________________________________________________________
#
# Terraform Cloud Workspace Variables: global_vars
#__________________________________________________________

module "tenant_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.tenant_workspace
  ]
  category     = "terraform"
  workspace_id = module.tenant_workspace.workspace.id
  variable_list = {
    intersight_org = {
      description = "Intersight Organization."
      key         = "organization"
      value       = var.organization
    },
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
      value       = "[${join(",", [for s in var.k8s_addons : format("%q", s)])}]"
    },
    k8s_addons_name = {
      description = "${var.tenant_name} Addons Policy Name."
      key         = "k8s_addons_name"
      value       = var.k8s_addons_name
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
  }
}
