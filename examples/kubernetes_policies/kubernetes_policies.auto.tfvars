#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

# endpoint     = "https://intersight.com"
organizations = ["default"]
# secretkey    = "../../../../intersight.secret"
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

#__________________________________________________________
#
# Intersight Global Tags Variable
# Default Tags if no resource tags are defined
#__________________________________________________________

tags = [{ key = "Terraform", value = "Module" }, { key = "Owner", value = "tyscott" }]


#______________________________________________
#
# Add-ons Policies Variables
#______________________________________________

addons_policies = {
  "ccp-monitor" = {
    organization = "default"
    # This is empty because I am accepting all the default values
  }
  "kubernetes-dashboard" = {
    install_strategy = "InstallOnly"
    organization     = "default"
    upgrade_strategy = "AlwaysReinstall"
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
  "#Tenant#_pool_v4" = {
    assignment_order = "sequential"
    ipv4_block = [
      {
        from = "10.96.110.101"
        to   = "10.96.110.200"
      },
    ]
    ipv4_config = {
      config = {
        gateway       = "10.96.110.1"
        netmask       = "255.255.255.0"
        primary_dns   = "10.101.128.15"
        secondary_dns = "10.101.128.16"
      }
    }
    ipv6_block   = []
    ipv6_config  = {}
    organization = "default"
    tags         = []
  }
  "#Tenant#_pool_v6" = {
    assignment_order = "sequential"
    ipv4_block       = []
    ipv4_config      = {}
    ipv6_block = [
      {
        from = "2001:110::101"
        size = 99
      }
    ]
    ipv6_config = {
      config = {
        gateway       = "2001:110::1"
        prefix        = 64
        primary_dns   = "2620:119:35::35"
        secondary_dns = "2620:119:53::53"
      }
    }
    organization = "default"
    tags         = []
  }
}

#__________________________________________________
#
# Kubernetes Version Policy Variables
#__________________________________________________

kubernetes_version_policies = {
  "#Tenant#_v1_19_5" = {
    organization = "default"
    # This is empty because I am accepting all the default values
  }
}

#______________________________________________
#
# Network CIDR Policy Variables
#______________________________________________

network_cidr_policies = {
  "#Tenant#_network_cidr" = {
    organization = "default"
    # This is empty because I am accepting all the default values
  }
}


#______________________________________________
#
# Node OS Configuration Policy Variables
#______________________________________________

nodeos_configuration_policies = {
  "#Tenant#_nodeos_config" = {
    dns_servers = ["10.101.128.15", "10.101.128.16"]
    dns_suffix  = "rich.ciscolabs.com"
    #  If ntp_servers is not set, dns_servers will be used as NTP servers
    # ntp_servers = []
    organization = "default"
    # For a List of timezones see
    # https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md.
    timezone = "America/New_York"
  }
}

#__________________________________________________
#
# Trusted Certificate Authorities Policy Variables
#__________________________________________________

trusted_certificate_authorities = {
  "#Tenant#_registry" = {
    organization        = "default"
    unsigned_registries = ["10.101.128.128"]
  }
}

#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

virtual_machine_infra_config = {
  "#Tenant#_vm_infra" = {
    organization          = "default"
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["prod|nets|Panther_VM1"]
    vsphere_resource_pool = "IKS"
    vsphere_target        = "#Tenant#-vcenter.rich.ciscolabs.com"
  }
}

#________________________________________________
#
# Virtual Machine Instance Type Policy Variables
#________________________________________________

virtual_machine_instance_type = {
  "#Tenant#_large" = {
    cpu          = 12
    disk         = 80
    memory       = 32768
    organization = "default"
  }
  "#Tenant#_medium" = {
    cpu          = 8
    disk         = 60
    memory       = 24576
    organization = "default"
  }
  "#Tenant#_small" = {
    organization = "default"
    # This is empty because I am accepting all the default values
  }
}
