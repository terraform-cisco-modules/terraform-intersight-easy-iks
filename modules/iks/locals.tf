locals {
  # Intersight Organization Variables
  org_name = var.organization
  org_moid = data.intersight_organization_organization.org_moid.results.0.moid
  ip_pools = {
    for k, v in jsondecode(var.ip_pools) : k => {
      from    = (v.from != null ? v.from : 20)
      gateway = (v.gateway != null ? v.gateway : "198.18.0.1/24")
      name    = (v.name != null ? v.name : "")
      size    = (v.size != null ? v.size : 30)
      tags    = (v.tags != null ? v.tags : [])
    }
  }
  k8s_addons = {
    for k, v in jsondecode(var.k8s_addons) : k => {
      install_strategy = (v.install_strategy != null ? v.install_strategy : "Always")
      name             = (v.name != null ? v.name : "")
      release_name     = (v.release_name != null ? v.release_name : "")
      tags             = (v.tags != null ? v.tags : [])
      upgrade_strategy = (v.upgrade_strategy != null ? v.upgrade_strategy : "UpgradeOnly")
    }
  }
  k8s_runtime = {
    for k, v in jsondecode(var.k8s_runtime) : k => {
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
    for k, v in jsondecode(var.k8s_trusted_registry) : k => {
      name     = (v.name != null ? v.name : "")
      root_ca  = (v.root_ca != null ? v.root_ca : [])
      tags     = (v.tags != null ? v.tags : [])
      unsigned = (v.unsigned != null ? v.unsigned : [])
    }
  }
  k8s_version = {
    for k, v in jsondecode(var.k8s_version) : k => {
      name    = (v.name != null ? v.name : "")
      tags    = (v.tags != null ? v.tags : [])
      version = (v.version != null ? v.version : "1.19.5")
    }
  }
  k8s_vm_infra = {
    for k, v in jsondecode(var.k8s_vm_infra) : k => {
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
    for k, v in jsondecode(var.k8s_vm_instance) : k => {
      cpu    = (v.cpu != null ? v.cpu : 4)
      disk   = (v.disk != null ? v.disk : 40)
      memory = (v.memory != null ? v.memory : 16384)
      tags   = (v.tags != null ? v.tags : [])
    }
  }
  k8s_vm_network = {
    for k, v in jsondecode(var.k8s_vm_network) : k => {
      cidr_pod     = (v.cidr_pod != null ? v.cidr_pod : "100.64.0.0/16")
      cidr_service = (v.cidr_service != null ? v.cidr_service : "100.65.0.0/16")
      cni          = (v.cni != null ? v.cni : "Calico")
      name         = (v.name != null ? v.name : "")
      tags         = (v.tags != null ? v.tags : [])
    }
  }
  # IKS Cluster Variables
  iks_cluster = {
    for k, v in jsondecode(var.iks_cluster) : k => {
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
  tags = jsondecode(var.tags)
}


