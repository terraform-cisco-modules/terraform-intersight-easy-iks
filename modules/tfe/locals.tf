locals {
  # IKS Cluster Variables
  iks_cluster = {
    for k, v in var.iks_cluster : k => {
      action_cluster                  = (v.action_cluster != null ? v.action_cluster : "Deploy")
      action_control_plane            = (v.action_control_plane != null ? v.action_control_plane : "No-op")
      action_worker                   = (v.action_worker != null ? v.action_worker : "No-op")
      control_plane_desired_size      = (v.control_plane_desired_size != null ? v.control_plane_desired_size : 1)
      control_plane_k8s_labels        = (v.control_plane_k8s_labels != null ? v.control_plane_k8s_labels : [])
      control_plane_max_size          = (v.control_plane_max_size != null ? v.control_plane_max_size : 3)
      description                     = (v.description != null ? v.description : "")
      ip_pool_moid                    = v.ip_pool_moid
      k8s_addon_policy_moid           = (v.k8s_addon_policy_moid != null ? v.k8s_addon_policy_moid : [])
      k8s_network_cidr_moid           = v.k8s_network_cidr_moid
      k8s_nodeos_config_moid          = v.k8s_nodeos_config_moid
      k8s_registry_moid               = (v.k8s_registry_moid != null ? v.k8s_registry_moid : "")
      k8s_runtime_moid                = (v.k8s_runtime_moid != null ? v.k8s_runtime_moid : "")
      k8s_version_moid                = v.k8s_version_moid
      k8s_vm_infra_moid               = v.k8s_vm_infra_moid
      k8s_vm_instance_type_ctrl_plane = v.k8s_vm_instance_type_ctrl_plane
      k8s_vm_instance_type_worker     = v.k8s_vm_instance_type_worker
      load_balancers                  = (v.load_balancers != null ? v.load_balancers : 3)
      organization                    = (v.organization != null ? v.organization : "default")
      ssh_key                         = v.ssh_key
      ssh_user                        = (v.ssh_user != null ? v.ssh_user : "iksadmin")
      tags                            = (v.tags != null ? v.tags : [])
      wait_for_complete               = (v.wait_for_complete != null ? v.wait_for_complete : false)
      worker_desired_size             = (v.worker_desired_size != null ? v.worker_desired_size : 1)
      worker_k8s_labels               = (v.worker_k8s_labels != null ? v.worker_k8s_labels : [])
      worker_max_size                 = (v.worker_max_size != null ? v.worker_max_size : 4)
    }
  }
  tags = var.tags
  # IKS Cluster Variables
  ip_pools = {
    for k, v in var.ip_pools : k => {
      description  = (v.description != null ? v.description : "")
      from         = (v.from != null ? v.from : 20)
      gateway      = (v.gateway != null ? v.gateway : "198.18.0.1/24")
      organization = (v.organization != null ? v.organization : "default")
      size         = (v.size != null ? v.size : 30)
      tags         = (v.tags != null ? v.tags : [])
    }
  }
  k8s_addon_policies = {
    for k, v in var.k8s_addon_policies : k => {
      description       = (v.description != null ? v.description : "")
      install_strategy  = (v.install_strategy != null ? v.install_strategy : "Always")
      organization      = (v.organization != null ? v.organization : "default")
      release_name      = (v.release_name != null ? v.release_name : "")
      release_namespace = (v.release_namespace != null ? v.release_namespace : "")
      tags              = (v.tags != null ? v.tags : [])
      upgrade_strategy  = (v.upgrade_strategy != null ? v.upgrade_strategy : "UpgradeOnly")
    }
  }
  k8s_network_cidr = {
    for k, v in var.k8s_network_cidr : k => {
      cidr_pod     = (v.cidr_pod != null ? v.cidr_pod : "100.64.0.0/16")
      cidr_service = (v.cidr_service != null ? v.cidr_service : "100.65.0.0/16")
      cni_type     = (v.cni_type != null ? v.cni_type : "Calico")
      description  = (v.description != null ? v.description : "")
      organization = (v.organization != null ? v.organization : "default")
      tags         = (v.tags != null ? v.tags : [])
    }
  }
  k8s_nodeos_config = {
    for k, v in var.k8s_nodeos_config : k => {
      description    = (v.description != null ? v.description : "")
      dns_servers_v4 = (v.dns_servers_v4 != null ? v.dns_servers_v4 : ["208.67.220.220", "208.67.222.222"])
      domain_name    = (v.domain_name != null ? v.domain_name : "example.com")
      ntp_servers    = (v.ntp_servers != null ? v.ntp_servers : [])
      organization   = (v.organization != null ? v.organization : "default")
      tags           = (v.tags != null ? v.tags : [])
      timezone       = (v.timezone != null ? v.timezone : "Etc/GMT")
    }
  }
  k8s_runtime_policies = {
    for k, v in var.k8s_runtime_policies : k => {
      description        = (v.description != null ? v.description : "")
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
      organization       = (v.organization != null ? v.organization : "default")
      tags               = (v.tags != null ? v.tags : [])
    }
  }
  k8s_trusted_registries = {
    for k, v in var.k8s_trusted_registries : k => {
      description  = (v.description != null ? v.description : "")
      organization = (v.organization != null ? v.organization : "default")
      root_ca      = (v.root_ca != null ? v.root_ca : [])
      tags         = (v.tags != null ? v.tags : [])
      unsigned     = (v.unsigned != null ? v.unsigned : [])
    }
  }
  k8s_version_policies = {
    for k, v in var.k8s_version_policies : k => {
      description  = (v.description != null ? v.description : "")
      organization = (v.organization != null ? v.organization : "default")
      tags         = (v.tags != null ? v.tags : [])
      version      = (v.version != null ? v.version : "1.19.5")
    }
  }
  k8s_vm_infra_config = {
    for k, v in var.k8s_vm_infra_config : k => {
      description           = (v.description != null ? v.description : "")
      organization          = (v.organization != null ? v.organization : "default")
      tags                  = (v.tags != null ? v.tags : [])
      vsphere_cluster       = coalesce(v.vsphere_cluster, "default")
      vsphere_datastore     = coalesce(v.vsphere_datastore, "datastore1")
      vsphere_portgroup     = coalesce(v.vsphere_portgroup, ["VM Network"])
      vsphere_resource_pool = (v.vsphere_resource_pool != null ? v.vsphere_resource_pool : "")
      vsphere_target        = coalesce(v.vsphere_target, "")
    }
  }
  k8s_vm_instance_type = {
    for k, v in var.k8s_vm_instance_type : k => {
      description  = (v.description != null ? v.description : "")
      cpu          = (v.cpu != null ? v.cpu : 4)
      disk         = (v.disk != null ? v.disk : 40)
      memory       = (v.memory != null ? v.memory : 16384)
      organization = (v.organization != null ? v.organization : "default")
      tags         = (v.tags != null ? v.tags : [])
    }
  }
}
