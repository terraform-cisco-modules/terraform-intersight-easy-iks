locals {
  # Intersight Organization Variable
  org_moid = data.intersight_organization_organization.org_moid.results[0].moid

  # Tags for Deployment
  tags = var.tags

  # Kubernetes Cluster Profiles Variables
  addons_policies = {
    for k, v in var.addons_policies : k => {
      description       = v.description != null ? v.description : ""
      install_strategy  = v.install_strategy != null ? v.install_strategy : "Always"
      release_namespace = v.release_namespace != null ? v.release_namespace : ""
      tags              = v.tags != null ? v.tags : []
      upgrade_strategy  = v.upgrade_strategy != null ? v.upgrade_strategy : "UpgradeOnly"
    }
  }
  container_runtime_policies = {
    for k, v in var.container_runtime_policies : k => {
      description               = v.description != null ? v.description : ""
      docker_daemon_bridge_cidr = v.docker_daemon_bridge_cidr != null ? v.docker_daemon_bridge_cidr : ""
      docker_no_proxy           = v.docker_no_proxy != null ? v.docker_no_proxy : []
      docker_http_proxy         = v.docker_http_proxy != null ? v.docker_http_proxy : []
      docker_https_proxy        = v.docker_https_proxy != null ? v.docker_https_proxy : []
      tags                      = v.tags != null ? v.tags : []
    }
  }
  ip_pools = {
    for k, v in var.ip_pools : k => {
      assignment_order = v.assignment_order != null ? v.assignment_order : "sequential"
      description      = v.description != null ? v.description : ""
      ipv4_blocks      = v.ipv4_blocks != null ? v.ipv4_blocks : {}
      ipv4_config      = v.ipv4_config != null ? v.ipv4_config : []
      ipv6_blocks      = v.ipv6_blocks != null ? v.ipv6_blocks : {}
      ipv6_config      = v.ipv6_config != null ? v.ipv6_config : []
      tags             = v.tags != null ? v.tags : []
    }
  }
  kubernetes_version_policies = {
    for k, v in var.kubernetes_version_policies : k => {
      description = v.description != null ? v.description : ""
      tags        = v.tags != null ? v.tags : []
      version     = v.version != null ? v.version : "v1.21.10"
    }
  }
  network_cidr_policies = {
    for k, v in var.network_cidr_policies : k => {
      cni_type         = v.cni_type != null ? v.cni_type : "Calico"
      description      = v.description != null ? v.description : ""
      pod_network_cidr = v.pod_network_cidr != null ? v.pod_network_cidr : "100.64.0.0/16"
      service_cidr     = v.service_cidr != null ? v.service_cidr : "100.65.0.0/16"
      tags             = v.tags != null ? v.tags : []
    }
  }
  nodeos_configuration_policies = {
    for k, v in var.nodeos_configuration_policies : k => {
      description = v.description != null ? v.description : ""
      dns_servers = v.dns_servers != null ? v.dns_servers : ["208.67.220.220", "208.67.222.222"]
      dns_suffix  = v.dns_suffix != null ? v.dns_suffix : "example.com"
      ntp_servers = v.ntp_servers != null ? v.ntp_servers : []
      tags        = v.tags != null ? v.tags : []
      timezone    = v.timezone != null ? v.timezone : "Etc/GMT"
    }
  }
  trusted_certificate_authorities = {
    for k, v in var.trusted_certificate_authorities : k => {
      description         = v.description != null ? v.description : ""
      root_ca_registries  = v.root_ca_registries != null ? v.root_ca_registries : []
      tags                = v.tags != null ? v.tags : []
      unsigned_registries = v.unsigned_registries != null ? v.unsigned_registries : []
    }
  }
  virtual_machine_infra_config = {
    for k, v in var.virtual_machine_infra_config : k => {
      description = v.description != null ? v.description : ""
      tags        = v.tags != null ? v.tags : []
      target      = v.target != null ? v.target : "vsphere.example.com"
      virtual_infrastructure = [
        for key, value in v.virtual_infrastructure : {
          cluster       = value.cluster != null ? value.cluster : "default"
          datastore     = value.datastore != null ? value.datastore : "datastore1"
          portgroup     = value.portgroup != null ? value.portgroup : ["VM Network"]
          resource_pool = value.resource_pool != null ? value.resource_pool : ""
          type          = value.type != null ? value.type : "vmware"
        }
      ]
    }
  }
  virtual_machine_instance_type = {
    for k, v in var.virtual_machine_instance_type : k => {
      description      = v.description != null ? v.description : ""
      cpu              = v.cpu != null ? v.cpu : 4
      memory           = v.memory != null ? v.memory : 16384
      system_disk_size = v.system_disk_size != null ? v.system_disk_size : 40
      tags             = v.tags != null ? v.tags : []
    }
  }
}
