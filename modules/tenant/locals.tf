locals {
  # Intersight Organization Variables
  org_name = var.organization
  org_moid = data.intersight_organization_organization.org_moid.results.0.moid
  ip_pools = {
    for k, v in var.ip_pools : k => {
      from    = (v.from    != null ? v.from    : 20)
      gateway = (v.gateway != null ? v.gateway : "198.18.0.1/24")
      name    = (v.name    != null ? v.name    : "")
      size    = (v.size    != null ? v.size    : 30)
      tags    = (v.tags    != null ? v.tags    : [])
    }
  }
  # k8s_runtime = {
  #   for k, v in var.k8s_runtime : k => {
  #     docker_bridge_cidr = (v.docker_bridge_cidr != null ? v.docker_bridge_cidr : "")
  #     docker_no_proxy    = (v.docker_no_proxy    != null ? v.docker_no_proxy    : [])
  #     http_hostname      = (v.http_hostname      != null ? v.http_hostname      : "")
  #     http_port          = (v.http_port          != null ? v.http_port          : 8080)
  #     http_protocol      = (v.http_protocol      != null ? v.http_protocol      : "http")
  #     http_username      = (v.http_username      != null ? v.http_username      : "")
  #     https_hostname     = (v.https_hostname     != null ? v.https_hostname     : "")
  #     https_port         = (v.https_port         != null ? v.https_port         : 8443)
  #     https_protocol     = (v.https_protocol     != null ? v.https_protocol     : "https")
  #     https_username     = (v.https_username     != null ? v.https_username     : "")
  #     name               = (v.name               != null ? v.name               : "")
  #     tags               = (v.tags               != null ? v.tags               : [])
  #   }
  # }
  # k8s_trusted_registry = {
  #   for k, v in var.k8s_trusted_registry : k => {
  #     name     = (v.name     != null ? v.name     : "")
  #     root_ca  = (v.root_ca  != null ? v.root_ca  : [])
  #     tags     = (v.tags     != null ? v.tags     : [])
  #     unsigned = (v.unsigned != null ? v.unsigned : [])
  #   }
  # }
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


