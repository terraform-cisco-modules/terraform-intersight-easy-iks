#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

# endpoint     = "https://intersight.com"
organization = "Wakanda"
# secretkey    = "~/Downloads/SecretKey.txt"
/*
  To export the Secret Key via an Environment Variable the format is as follows (Note: they are not quotation marks, but escape characters):
  - export TF_VAR_secretkey=`cat ../../intersight.secret`
  Either way will work in this case as we are not posting the contents of the file here.
*/
/*
  We highly recommend that for the apikey you use an environment variable for input:
  - export TF_VAR_apikey="abcdefghijklmnopqrstuvwxyz.0123456789"
*/
# apikey = "value"

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

#______________________________________________
#
# Add-ons Policies Variables
#______________________________________________

addons_policies = {
  "ccp-monitor" = {
    install_strategy  = "Always"
    release_namespace = "ccp-monitor"
    upgrade_strategy  = "ReinstallOnFailure"
  }
  "kubernetes-dashboard" = {
    install_strategy  = "Always"
    release_namespace = "kubernetes-dashboard"
    upgrade_strategy  = "ReinstallOnFailure"
  }
}


#__________________________________________________
#
# Container Runtime Policy Variables
#__________________________________________________

container_runtime_policies = {}


#______________________________________________
#
# IP Pool Variables
#______________________________________________

ip_pools = {
  "iks" = {
    assignment_order = "sequential"
    description      = ""
    ipv4_blocks = {
      "0" = {
        from = "10.96.112.1"
        size = 128
        # to   = "10.96.112.128"
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



#__________________________________________________
#
# Kubernetes Version Policy Variables
#__________________________________________________

kubernetes_version_policies = {
  "v1.20.14" = {
    version = "v1.20.14"
  }
  "v1.21.10" = {
    version = "v1.21.10"
  }
}


#______________________________________________
#
# Network CIDR Policy Variables
#______________________________________________

network_cidr_policies = {
  "Wakanda_CIDR" = {
    cni_type         = "Calico"
    pod_network_cidr = "100.71.0.0/16"
    service_cidr     = "100.72.0.0/16"
  }
}


#______________________________________________
#
# Node OS Configuration Policy Variables
#______________________________________________

nodeos_configuration_policies = {
  "Wakanda" = {
    dns_servers = ["10.101.128.15", "10.101.128.16"]
    dns_suffix  = "rich.ciscolabs.com"
    ntp_servers = ["10.101.128.15", "10.101.128.16"]
    timezone    = "America/New_York"
  }
}

#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

virtual_machine_infra_config = {
  "Panther" = {
    description = ""
    tags        = []
    target      = "wakanda-vcenter.rich.ciscolabs.com"
    virtual_infrastructure = [{
      cluster       = "Panther"
      datastore     = "NVMe_DS1"
      portgroup     = ["prod|nets|Wakanda_IKS"]
      resource_pool = ""
      type          = "vmware"
    }]
  }
}


#________________________________________________
#
# Virtual Machine Instance Type Policy Variables
#________________________________________________

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
