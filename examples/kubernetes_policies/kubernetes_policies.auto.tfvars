# Intersight Organization
organization = "Wakanda"

# Global Tag Values - Consumed by Policies if no specific Tags are defined.
tags = [
  {
    "key"   = "terraform-intersight-easy-iks"
    "value" = "1.5.1"
  },
  {
    "key"   = "deployed-by"
    "value" = "tyscott"
  }
]

# IP Pools
ip_pools = {
  "iks" = {
    assignment_order = "sequential"
    description      = ""
    ipv4_blocks = {
      "0" = {
        from = "10.96.112.1"
        size = 128
        to   = "10.96.112.128"
      }
    }
    ipv4_config = [{
      gateway       = "10.96.112.254"
      netmask       = "255.255.255.0"
      primary_dns   = "10.101.128.15"
      secondary_dns = "10.101.128.16"
    }]
    ipv6_blocks = {}
    ipv6_config = []
    tags        = []
  }
}

#______________________________
#
# Kubernetes Policies
#______________________________

# Addons
addons_policies = {
  "ccp-monitor" = {
    install_strategy = "Always"
    upgrade_strategy = "ReinstallOnFailure"
  }
  "kubernetes-dashboard" = {
    install_strategy = "Always"
    upgrade_strategy = "ReinstallOnFailure"
  }
  "smm1_7" = {
    chart_name       = "smm"
    chart_version    = "1.7.4-cisco4-helm3"
    install_strategy = "Always"
    release_name     = "smm1.7"
    upgrade_strategy = "ReinstallOnFailure"
  }
  "smm1_8" = {
    chart_name       = "smm"
    chart_version    = "1.8.2-cisco2-helm3"
    install_strategy = "Always"
    overrides        = "demoApplication,enabled,true"
    release_name     = "smm1.8"
    upgrade_strategy = "ReinstallOnFailure"
  }
}

# Container Runtime
container_runtime_policies = {}

# Kubernetes Version
kubernetes_version_policies = {
  "v1.20.14" = {
    version = "v1.20.14"
  }
  "v1.21.10" = {
    version = "v1.21.10"
  }
}

# Network CIDR Policies
network_cidr_policies = {
  "Wakanda_CIDR" = {
    cni_type         = "Calico"
    pod_network_cidr = "100.71.0.0/16"
    service_cidr     = "100.72.0.0/16"
  }
}

# NodeOS Configuration
nodeos_configuration_policies = {
  "Wakanda" = {
    dns_servers = ["10.101.128.15", "10.101.128.16"]
    dns_suffix  = "rich.ciscolabs.com"
    ntp_servers = ["10.101.128.15", "10.101.128.16"]
    timezone    = "America/New_York"
  }
}

# Trusted Certificate Authorities
trusted_certificate_authorities = {}

# VM Infra Config
virtual_machine_infra_config = {
  "Panther" = {
    description = ""
    tags        = []
    target      = "wakanda-vcenter.rich.ciscolabs.com"
    virtual_infrastructure = [{
      cluster       = "Panther"
      datastore     = "NVMe_DS1"
      interfaces    = ["prod|nets|Wakanda_IKS"]
      resource_pool = ""
      type          = "vmware"
    }]
  }
  "Terminus" = {
    description = ""
    tags        = []
    target      = "terminus"
    virtual_infrastructure = [{
      interfaces    = ["iwe-guests"]
      provider_name = "iwe-guests"
      type          = "iwe"
    }]
  }
}

# VM Instance Type
virtual_machine_instance_type = {
  "Small" = {}
  "Medium" = {
    cpu              = 8
    memory           = 24576
    system_disk_size = 60
  }
  "Large" = {
    cpu              = 12
    memory           = 32768
    system_disk_size = 80
  }
}