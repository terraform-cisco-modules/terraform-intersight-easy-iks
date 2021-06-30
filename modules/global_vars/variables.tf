#__________________________________________________________
#
# Intersight Provider Variables
#__________________________________________________________

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}
output "endpoint" {
  description = "Intersight URL."
  value       = var.endpoint
}

#__________________________________________________________
#
# Intersight Organization Variables
#__________________________________________________________

variable "organization" {
  default     = "default"
  description = "Intersight Organization."
  type        = string
}
output "organization" {
  description = "Intersight Organization Name."
  value       = var.organization
}

#______________________________________________
#
# Prefix Variable
#______________________________________________

variable "network_prefix" {
  default     = "10.200.0"
  description = "Network Prefix to Assign to DNS/NTP Servers & vCenter Target default values."
  type        = string
  validation {
    condition     = (can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.network_prefix)))
    error_message = "The network_prefix must be in the format X.X.X."
  }
}


#______________________________________________
#
# DNS Variables
#______________________________________________

variable "domain_name" {
  default     = "demo.intra"
  description = "Domain Name for Kubernetes Sysconfig Policy."
  type        = string
}
output "domain_name" {
  description = "Domain Name."
  value       = var.domain_name
}

variable "dns_servers" {
  default     = ["10.200.0.100"]
  description = "List of DNS Server(s) for Kubernetes System Configuration Policy and IP Pool."
  type        = list(string)
  #  validation {
  #    condition = (
  #      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.dns_primary))
  #    )
  #    error_message = "The dns_servers must be in the format X.X.X.X or X."
  #  }
}
output "dns_servers" {
  description = "List of DNS Server(s) for Kubernetes System Configuration Policy and IP Pool."
  value       = var.dns_servers
}

#______________________________________________
#
# Time Variables
#______________________________________________

variable "timezone" {
  default     = "America/New_York"
  description = "Timezone for Kubernetes Sysconfig Policy."
  type        = string
}
output "timezone" {
  description = "Timezone."
  value       = var.timezone
}

variable "ntp_servers" {
  default     = []
  description = "List of NTP Server for Kubernetes System Configuration Policy.  If undefined then the dns_servers will be used."
  type        = list(string)
}
output "ntp_servers" {
  description = "List of NTP Server for Kubernetes System Configuration Policy.  If undefined then the dns_servers will be used."
  value       = length(var.ntp_servers) != 0 ? var.ntp_servers : var.dns_servers
}

#______________________________________________
#
# IKS Cluster Variable
#______________________________________________

variable "cluster_name" {
  default     = "iks"
  description = "Intersight Kubernetes Service Cluster Name."
  type        = string
}
output "cluster_name" {
  description = "Intersight Kubernetes Service Cluster Name."
  value       = var.cluster_name
}


#______________________________________________
#
# Intersight IP Pool Variables
#______________________________________________

variable "ip_pool" {
  default     = ""
  description = "Intersight Kubernetes Service IP Pool.  Default name is {cluster_name}_ip_pool"
  type        = string
}
output "ip_pool" {
  description = "IP Pool Policy Name."
  value       = var.ip_pool != "" ? var.ip_pool : join("-", [var.cluster_name, "ip_pool"])
}

variable "ip_pool_netmask" {
  default     = "255.255.255.0"
  description = "IP Pool Netmask."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.ip_pool_netmask))
    )
    error_message = "The ip_pool_netmask must be in the format X.X.X.X."
  }
}
output "ip_pool_netmask" {
  description = "IP Pool Netmask Value."
  value       = var.ip_pool_netmask
}

variable "ip_pool_gateway" {
  default     = "254"
  description = "IP Pool Gateway last Octet.  The var.network_prefix will be combined with ip_pool_gateway for the Gateway Address."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.ip_pool_gateway)) ||
      can(regex("^[0-9]{1,3}$", var.ip_pool_gateway))
    )
    error_message = "The ip_pool_gateway must be in the format X.X.X.X or X."
  }
}
output "ip_pool_gateway" {
  description = "IP Pool Gateway Value."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.ip_pool_gateway))}${var.ip_pool_gateway}%{endif}
  %{if can(regex("^[0-9]{1,3}$", var.ip_pool_gateway))}${join(".", [var.network_prefix, var.ip_pool_gateway])}%{endif}
  EOT
  )
}

variable "ip_pool_from" {
  default     = "20"
  description = "IP Pool Starting IP last Octet.  The var.network_prefix will be combined with ip_pool_from for the Starting Address."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}$", var.ip_pool_from))
    )
    error_message = "The ip_pool_from must be in the format X."
  }
}
output "ip_pool_from" {
  description = "IP Pool Starting IP Value."
  value       = join(".", [var.network_prefix, var.ip_pool_from])
}

variable "ip_pool_size" {
  default     = "30"
  description = "IP Pool Block Size."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}$", var.ip_pool_size))
    )
    error_message = "The ip_pool_size must be in the X."
  }
}
output "ip_pool_size" {
  description = "IP Pool Block Size."
  value       = var.ip_pool_size
}

#______________________________________________
#
# Kubernetes Add-ons Policy Variables
#______________________________________________

variable "addons_list" {
  default     = []
  description = "List of Add-ons for Intersight Kubernetes Service.  Add-ons Options are {ccp-monitor|kubernetes-dashboard}."
  type        = list(string)
}
output "addons_list" {
  description = "List of Add-ons for Policy Creation."
  value = [
    for a in var.addons_list :
    {
      addon_policy_name = "${var.cluster_name}_${a}"
      addon             = a
      description       = "Policy for ${a}"
      upgrade_strategy  = "AlwaysReinstall"
      install_strategy  = "InstallOnly"
    }
  ]
}


#______________________________________________
#
# Kubernetes Runtime Variables
#______________________________________________

variable "proxy_http_hostname" {
  default     = ""
  description = "HTTP Proxy Server Name or IP Address."
  type        = string
}
output "proxy_http_hostname" {
  description = "HTTP Proxy Server Name or IP Address."
  value       = var.proxy_http_hostname
}

variable "proxy_http_username" {
  default     = ""
  description = "HTTP Proxy Username."
  type        = string
}
output "proxy_http_username" {
  description = "HTTP Proxy Username."
  value       = var.proxy_http_username
}

variable "proxy_https_hostname" {
  default     = ""
  description = "HTTPS Proxy Server Name or IP Address."
  type        = string
}
output "proxy_https_hostname" {
  description = "HTTPS Proxy Server Name or IP Address.  If Left blank, and proxy_http_hostname is defined, it will be copied to here."
  value       = var.proxy_https_hostname != [] ? var.proxy_https_hostname : var.proxy_http_hostname
}

variable "proxy_https_username" {
  default     = ""
  description = "HTTPS Proxy Username."
  type        = string
}
output "proxy_https_username" {
  description = "HTTPS Proxy Username."
  value       = var.proxy_https_username != [] ? var.proxy_https_username : var.proxy_http_username
}


#______________________________________________
#
# Kubernetes Policy Names
#______________________________________________

variable "k8s_addon_policy" {
  default     = ""
  description = "Kubernetes Runtime Policy Name.  Default name is {cluster_name}-runtime."
  type        = string
}
output "k8s_addon_policy" {
  description = "Kubernetes Trusted Registry Policy Name."
  value       = var.k8s_addon_policy != "" ? var.k8s_addon_policy : join("-", [var.cluster_name, "addon"])
}

variable "k8s_runtime_policy" {
  default     = ""
  description = "Kubernetes Runtime Policy Name.  Default name is {cluster_name}-runtime."
  type        = string
}
output "k8s_runtime_policy" {
  description = "Kubernetes Trusted Registry Policy Name."
  value       = var.k8s_runtime_policy != "" ? var.k8s_runtime_policy : join("-", [var.cluster_name, "runtime"])
}

variable "k8s_trusted_registry" {
  default     = ""
  description = "Kubernetes Trusted Registry Policy Name.  Default name is {cluster_name}-registry."
  type        = string
}
output "k8s_trusted_registry" {
  description = "Kubernetes Trusted Registry Policy Name."
  value       = var.k8s_trusted_registry != "" ? var.k8s_trusted_registry : join("-", [var.cluster_name, "registry"])
}

variable "k8s_version_policy" {
  default     = ""
  description = "Kubernetes Version Policy Name.  Default name is {cluster_name}-k8s-version."
  type        = string
}
output "k8s_version_policy" {
  description = "Kubernetes Version Policy Name."
  value       = var.k8s_version_policy != "" ? var.k8s_version_policy : join("-", [var.cluster_name, "k8s-version"])
}

variable "k8s_vm_network_policy" {
  default     = ""
  description = "Kubernetes Network/System Configuration Policy (CIDR, dns, ntp, etc.).  Default name is {cluster_name}-sysconfig."
  type        = string
}
output "k8s_vm_network_policy" {
  description = "Kubernetes VM Network Policy Name."
  value       = var.k8s_vm_network_policy != "" ? var.k8s_vm_network_policy : join("-", [var.cluster_name, "sysconfig"])
}

variable "k8s_vm_infra_policy" {
  default     = ""
  description = "Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {cluster_name}-vm-infra-config."
  type        = string
}
output "k8s_vm_infra_policy" {
  description = "Kubernetes VM Infrastructure Policy Name."
  value       = var.k8s_vm_infra_policy != "" ? var.k8s_vm_infra_policy : join("-", [var.cluster_name, "vm-infra-config"])
}


#______________________________________________
#
# K8S VM Infra Policy Variables
#______________________________________________
#
variable "vsphere_target" {
  default     = "210"
  description = "vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.vsphere_target)) ||
      can(regex("^[0-9]{1,3}$", var.vsphere_target)) ||
      can(regex("^[[:alnum:]]+", var.vsphere_target))
    )
    error_message = "The vsphere_target must be in the format hostname or IPv4 Address or just a number."
  }
}
output "vsphere_target" {
  description = "vSphere Target."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.vsphere_target))}${var.vsphere_target}%{endif}
  %{if can(regex("^[0-9]{1,3}$", var.vsphere_target))}${join(".", [var.network_prefix, var.vsphere_target])}%{endif}
  %{if can(regex("^[[:alnum:]]+", var.vsphere_target))}${var.vsphere_target}%{endif}
  EOT
  )
}
