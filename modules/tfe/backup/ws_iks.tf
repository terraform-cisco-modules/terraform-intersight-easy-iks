terraform {
  experiments = [module_variable_optional_attrs]
}

locals {
  cluster_variables = {
    for k, v in var.cluster_variables : k => {
      addons_list           = (v.addons_list != null ? v.addons_list : [])
      cluster_name          = coalesce(v.cluster_name, "iks")
      ip_pool_gateway       = coalesce(v.ip_pool_gateway, "198.18.")
      ip_pool_from          = coalesce(v.ip_pool_from, "iks")
      vsphere_target        = optional(string)
      vsphere_cluster       = optional(string)
      vsphere_datastore     = optional(string)
      vsphere_portgroup     = optional(list(string))
      vsphere_resource_pool = optional(string)
      annotation            = (v.annotation != null ? v.annotation : "")
      name                  = coalesce(v.name, "l3out")
      name_alias            = (v.name_alias != null ? v.name_alias : "")
      vlan_pool             = coalesce(v.vlan_pool, "")
    }
  }
}

#______________________________________________
#
# IP Pool Variables - When Shared
#______________________________________________

variable "ip_pool_gateway" {
  default     = "198.18.0.1/24"
  description = "IP Pool Gateway last Octet.  The var.network_prefix will be combined with ip_pool_gateway for the Gateway Address."
  type        = string
}

variable "ip_pool_from" {
  default     = "20"
  description = "IP Pool Starting IP last Octet.  The var.network_prefix will be combined with ip_pool_from for the Gateway Address."
  type        = string
}

#______________________________________________
#
# K8S Network CIDR/System - When Shared
#______________________________________________

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
# Kubernetes Runtime Variables
#______________________________________________

variable "docker_no_proxy" {
  default     = "[]"
  description = "Docker no proxy list, when using internet proxy.  Default is no list."
  type        = string
}

variable "proxy_http_hostname" {
  default     = ""
  description = "HTTP Proxy Server Name or IP Address."
  type        = string
}

variable "proxy_http_password" {
  default     = ""
  description = "Password for the HTTP Proxy Server, If required."
  sensitive   = true
  type        = string
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

variable "proxy_http_username" {
  default     = ""
  description = "HTTP Proxy Username."
  type        = string
}

variable "proxy_https_hostname" {
  default     = ""
  description = "HTTPS Proxy Server Name or IP Address."
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

variable "proxy_https_username" {
  default     = ""
  description = "HTTPS Proxy Username."
  type        = string
}


#______________________________________________
#
# K8S VM Infrastructure Policy Variables
#______________________________________________

variable "vsphere_target" {
  default     = "210"
  description = "vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox."
  type        = string
}

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
  default     = "[Management]"
  description = "vSphere Port Group to assign the K8S Cluster Deployment."
  type        = string
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
  default     = "[]"
  description = "List of root CA Signed Registries."
  type        = string
}

variable "unsigned_registries" {
  default     = "[]"
  description = "List of unsigned registries to be supported."
  type        = string
}

#______________________________________________
#
# Intersight Tags
#______________________________________________

variable "tags" {
  default     = "[]"
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = string
}


#______________________________________________
#
# Intersight Kubernetes Cluster Variables
#______________________________________________

variable "action" {
  default     = "Deploy"
  description = "Action to perform on the Intersight Kubernetes Cluster.  Options are {Deploy|Ready|Unassign}."
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
  sensitive   = false
  type        = string
}

#______________________________________________
#
# Control Plane Node Profile Variables
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
# Worker Node Profile Variables
#______________________________________________

variable "worker_instance_type" {
  default     = "small"
  description = "K8S Worker Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "worker_desired_size" {
  default     = 1
  description = "K8S Worker Desired Cluster Size."
  type        = string
}

variable "worker_max_size" {
  default     = 4
  description = "K8S Worker Maximum Cluster Size."
  type        = string
}


#______________________________________________
#
# Kubernetes Add-ons List
#______________________________________________

variable "addons_list" {
  default     = "[]"
  description = "List of Add-ons to be added to Cluster."
  type        = string
}

#__________________________________________________________
#
# Terraform Cloud Workspaces
#__________________________________________________________

module "iks_workspaces" {
  source            = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each          = var.k8s_cluster_variables
  auto_apply        = true
  description       = "Intersight Kubernetes Service Workspace."
  name              = "${var.name_prefix}_${each.value.cluster_name}_iks"
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
  for_each     = var.k8s_cluster_variables
  category     = "terraform"
  workspace_id = module.iks_workspaces["${each.value.cluster_name}"].workspace.id
  variable_list = [
    #---------------------------
    # Terraform Cloud Variables
    #---------------------------
    {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    {
      description = "global_vars Workspace."
      key         = "ws_global_vars"
      value       = "${var.prefix_value}_global_vars"
    },
    #---------------------------
    # Intersight Variables
    #---------------------------
    {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    },
    #-----------------------------
    # Kubernetes Policy Variables
    #-----------------------------
    {
      description = "Kubernetes Network Pod CIDR."
      key         = "k8s_pod_cidr"
      value       = each.value.k8s_pod_cidr != null ? each.value.k8s_pod_cidr : var.k8s_pod_cidr
    },
    {
      description = "Kubernetes Network Service CIDR."
      key         = "k8s_service_cidr"
      value       = each.value.k8s_service_cidr != null ? each.value.k8s_service_cidr : var.k8s_service_cidr
    },
    {
      description = "Kubernetes Version."
      key         = "k8s_version"
      value       = each.value.k8s_version != null ? each.value.k8s_version : var.k8s_version
    },
    {
      description = "Docker no proxy list, when using internet proxy.  Default is no list."
      hcl         = true
      key         = "docker_no_proxy"
      value       = var.docker_no_proxy
    },
    {
      description = "Password for the HTTP Proxy Server, If required."
      key         = "proxy_http_password"
      sensitive   = true
      value       = var.proxy_http_password
    },
    {
      description = "Proxy HTTP Port."
      key         = "proxy_http_port"
      value       = var.proxy_http_port
    },
    {
      description = "Proxy HTTP Protocol."
      key         = "proxy_http_protocol"
      value       = var.proxy_http_protocol
    },
    {
      description = "Password for the HTTPS Proxy Server, If required."
      key         = "proxy_https_password"
      sensitive   = true
      value       = var.proxy_https_password
    },
    {
      description = "Proxy HTTPS Port."
      key         = "proxy_https_port"
      value       = var.proxy_https_port
    },
    {
      description = "Proxy HTTPS Protocol."
      key         = "proxy_https_protocol"
      value       = var.proxy_https_protocol
    },
    {
      description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
      key         = "vsphere_password"
      sensitive   = true
      value       = var.vsphere_password
    },
    {
      description = "vSphere Cluster to assign the K8S Cluster Deployment."
      key         = "vsphere_cluster"
      value       = each.value.vsphere_cluster != null ? each.value.vsphere_cluster : var.vsphere_cluster
    },
    {
      description = "vSphere Datastore to assign the K8S Cluster Deployment."
      key         = "vsphere_datastore"
      value       = each.value.vsphere_datastore != null ? each.value.vsphere_datastore : var.vsphere_datastore
    },
    {
      description = "vSphere Port Group to assign the K8S Cluster Deployment."
      hcl         = true
      key         = "vsphere_portgroup"
      value       = each.value.vsphere_portgroup != null ? each.value.vsphere_portgroup : var.vsphere_portgroup
    },
    {
      description = "vSphere Resource Pool to assign the K8S Cluster Deployment."
      key         = "vsphere_resource_pool"
      value       = each.value.vsphere_resource_pool != null ? each.value.vsphere_resource_pool : var.vsphere_resource_pool
    },
    {
      description = "List of root CA Signed Registries."
      hcl         = true
      key         = "root_ca_registries"
      value       = each.value.root_ca_registries != null ? each.value.root_ca_registries : var.root_ca_registries
    },
    {
      description = "List of unsigned registries to be supported."
      hcl         = true
      key         = "unsigned_registries"
      value       = each.value.unsigned_registries != null ? each.value.unsigned_registries : var.unsigned_registries
    },
    {
      description = "Tags to be Associated with Objects Created in Intersight."
      hcl         = true
      key         = "tags"
      value       = each.value.tags != null ? each.value.tags : var.tags
    },
    #---------------------------
    # IKS Cluster Variables
    #---------------------------
    {
      description = "IKS Cluster Name."
      key         = "cluster_name"
      value       = var.cluster_name
    },
    {
      description = "Kubernetes Add-ons Policy List."
      hcl         = true
      key         = "addons_list"
      value       = var.addons_list
    },
    {
      description = "Network Prefix for IP Pool Policy."
      key         = "network_prefix"
      value       = var.network_prefix
    },
    {
      description = "IP Pool Gateway last Octet."
      key         = "ip_pool_gateway"
      value       = var.ip_pool_gateway
    },
    {
      description = "IP Pool Starting Address."
      key         = "ip_pool_from"
      value       = var.ip_pool_from
    },
    {
      description = "HTTP Proxy Server Name or IP Address."
      key         = "proxy_http_hostname"
      value       = var.proxy_http_hostname
    },
    {
      description = "HTTP Proxy Username."
      key         = "proxy_http_username"
      value       = var.proxy_http_username
    },
    {
      description = "HTTPS Proxy Server Name or IP Address."
      key         = "proxy_https_hostname"
      value       = var.proxy_https_hostname
    },
    {
      description = "HTTPS Proxy Username."
      key         = "proxy_https_username"
      value       = var.proxy_https_username
    },
    {
      description = "vSphere Server registered as a Target in Intersight."
      key         = "vsphere_target"
      value       = var.vsphere_target
    },
    {
      description = "Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete|Deploy|Ready|Unassign}."
      hcl         = false
      key         = "action"
      sensitive   = false
      value       = each.value.action
    },
    {
      description = "Intersight Kubernetes Load Balancer count."
      hcl         = false
      key         = "load_balancers"
      sensitive   = false
      value       = each.value.load_balancers
    },
    {
      description = "Intersight Kubernetes Service Cluster Default User."
      hcl         = false
      key         = "ssh_user"
      sensitive   = false
      value       = each.value.ssh_user
    },
    {
      description = "Intersight Kubernetes Service Cluster Default User."
      hcl         = false
      key         = "ssh_key"
      sensitive   = true
      value       = each.value.ssh_key != null ? each.value.ssh_key : var.ssh_key
    },
    {
      description = "K8S Control Plane Virtual Machine Instance Type.  Options are {small|medium|large}."
      key         = "control_plane_instance_type"
      value       = each.value.control_plane_instance_type != null ? each.value.control_plane_instance_type : var.control_plane_instance_type
    },
    {
      description = "K8S Control Plane Desired Cluster Size."
      key         = "control_plane_desired_size"
      value       = each.value.control_plane_desired_size != null ? each.value.control_plane_desired_size : var.control_plane_desired_size
    },
    {
      description = "K8S Control Plane Maximum Cluster Size."
      key         = "control_plane_max_size"
      value       = each.value.control_plane_max_size != null ? each.value.control_plane_max_size : var.control_plane_max_size
    },
    {
      description = "K8S Worker Virtual Machine Instance Type.  Options are {small|medium|large}."
      key         = "worker_instance_type"
      value       = each.value.worker_instance_type != null ? each.value.worker_instance_type : var.worker_instance_type
    },
    {
      description = "K8S Worker Desired Cluster Size."
      key         = "worker_desired_size"
      value       = each.value.worker_desired_size != null ? each.value.worker_desired_size : var.worker_desired_size
    },
    {
      description = "K8S Worker Maximum Cluster Size."
      hcl         = false
      key         = "worker_max_size"
      sensitive   = false
      value       = each.value.worker_max_size != null ? each.value.worker_max_size : var.worker_max_size
    },
  ]
}
