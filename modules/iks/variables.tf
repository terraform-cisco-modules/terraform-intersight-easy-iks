#__________________________________________________________
#
# Terraform Cloud Organization
#__________________________________________________________

variable "tfc_organization" {
  default     = "CiscoDevNet"
  description = "Terraform Cloud Organization."
  type        = string
}


#______________________________________________
#
# Terraform Cloud global_vars Workspace
#______________________________________________

variable "ws_global_vars" {
  default     = ""
  description = "Global Variables Workspace Name.  The default value will be set to {prefix_value}_global_vars by the tfe variable module."
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
# Kubernetes Policy Variables
#__________________________________________________________

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
  description = "Kubernetes Addon Policy Name.  Default name is {cluster_name}_addon."
  type        = string
}
output "k8s_addon_policy" {
  description = "Kubernetes Addon Policy Name."
  value       = var.k8s_addon_policy != "" ? var.k8s_addon_policy : join("_", [var.cluster_name, "addon"])
}

variable "k8s_runtime_policy" {
  default     = ""
  description = "Kubernetes Runtime Policy Name.  Default name is {cluster_name}_runtime."
  type        = string
}
output "k8s_runtime_policy" {
  description = "Kubernetes Runtime Policy Name."
  value       = var.k8s_runtime_policy != "" ? var.k8s_runtime_policy : join("_", [var.cluster_name, "runtime"])
}

variable "k8s_trusted_registry" {
  default     = ""
  description = "Kubernetes Trusted Registry Policy Name.  Default name is {cluster_name}_registry."
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

variable "k8s_vm_infra_policy" {
  default     = ""
  description = "Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {cluster_name}-vm-infra-config."
  type        = string
}
output "k8s_vm_infra_policy" {
  description = "Kubernetes VM Infrastructure Policy Name."
  value       = var.k8s_vm_infra_policy != "" ? var.k8s_vm_infra_policy : join("-", [var.cluster_name, "vm-infra-config"])
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

#______________________________________________
#
# Kubernetes Network CIDR/System Policies
#______________________________________________

variable "cni" {
  type        = string
  description = "Supported CNI type. Currently we only support Calico.\r\n* Calico - Calico CNI plugin as described in:\r\n https://github.com/projectcalico/cni-plugin."
  default     = "Calico"
}

variable "k8s_pod_cidr" {
  default     = "100.65.0.0/16"
  description = "Pod CIDR Block to be used to assign Pod IP Addresses."
  type        = string
}

variable "k8s_service_cidr" {
  default     = "100.64.0.0/16"
  description = "Service CIDR Block used to assign Cluster Service IP Addresses."
  type        = string
}

variable "k8s_version" {
  default     = "1.19.5"
  description = "Kubernetes Version to Deploy."
  type        = string
}


#______________________________________________
#
# Kubernetes Runtime Policy Variables
#______________________________________________

variable "docker_no_proxy" {
  default     = []
  description = "Docker no proxy list, when using internet proxy.  Default is no list."
  type        = list(string)
}

variable "proxy_http_port" {
  default     = "8080"
  description = "Proxy HTTP Port."
  type        = string
}

variable "proxy_http_protocol" {
  default     = "http"
  description = "Proxy HTTP Protocol."
  type        = string
}

variable "proxy_http_password" {
  default     = ""
  description = "Password for the HTTP Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "proxy_https_password" {
  default     = ""
  description = "Password for the HTTPS Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "proxy_https_port" {
  default     = "8443"
  description = "Proxy HTTP Port."
  type        = string
}

variable "proxy_https_protocol" {
  default     = "https"
  description = "Proxy HTTP Protocol."
  type        = string
}


#______________________________________________
#
# Kubernetes VM Infra Policy Variables
#______________________________________________

variable "vsphere_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}

variable "vsphere_cluster" {
  default     = "hx-demo"
  description = "vSphere Cluster to assign the K8S Cluster Deployment."
  type        = string
}

variable "vsphere_datastore" {
  default     = "hx-demo-ds1"
  description = "vSphere Datastore to assign the K8S Cluster Deployment."
  type        = string
}

variable "vsphere_portgroup" {
  default     = ["VM"]
  description = "vSphere Port Group to assign the K8S Cluster Deployment."
}

variable "vsphere_resource_pool" {
  default     = ""
  description = "vSphere Resource Pool to assign the K8S Cluster Deployment."
  type        = string
}

#______________________________________________
#
# Trusted Registries Variables
#______________________________________________

variable "root_ca_registries" {
  default     = []
  description = "List of root CA Signed Registries."
  type        = list(string)
}

variable "unsigned_registries" {
  default     = []
  description = "List of unsigned registries to be supported."
  type        = list(string)
}

#______________________________________________
#
# Tags to Assign to the Policies and Cluster
#______________________________________________

variable "tags" {
  default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = list(map(string))
}


#__________________________________________________________
#
# Intersight Kubernetes Service Cluster Variables
#__________________________________________________________

#______________________________________________
#
# IKS Cluster Variables
#______________________________________________

variable "action" {
  default     = "Deploy"
  description = "Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete|Deploy|Ready|Unassign}."
  type        = string
}

variable "load_balancers" {
  default     = 3
  description = "Intersight Kubernetes Load Balancer count."
  type        = string
}

variable "ssh_user" {
  default     = "iksadmin"
  description = "Intersight Kubernetes Service Cluster Default User."
  type        = string
}

variable "ssh_key" {
  description = "Intersight Kubernetes Service Cluster SSH Public Key."
  sensitive   = true
  type        = string
}


#______________________________________________
#
# Kubernetes Control Plane Variables
#______________________________________________

variable "control_plane_instance_type" {
  default     = "small"
  description = "K8S Control Plane Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "control_plane_desired_size" {
  default     = 1
  description = "K8S Control Plane Desired Cluster Size."
  type        = string
}

variable "control_plane_max_size" {
  default     = 1
  description = "K8S Control Plane Maximum Cluster Size."
  type        = string
}

#______________________________________________
#
# Kubernetes Worker Variables
#______________________________________________

variable "worker_instance_type" {
  default     = "small"
  description = "K8S Worker Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "worker_desired_size" {
  default     = 0
  description = "K8S Worker Desired Cluster Size."
  type        = string
}

variable "worker_max_size" {
  default     = 4
  description = "K8S Worker Maximum Cluster Size."
  type        = string
}
