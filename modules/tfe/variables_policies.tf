#__________________________________________________________
#
# Kubernetes Policy Variables
#__________________________________________________________

#______________________________________________
#
# Kubernetes Add-ons Policy Variables
#______________________________________________

variable "k8s_addon_policies" {
  default = {
    default = { # The Addon Policy Name will be {each.key}.  In this case it would be default if left like this.
      description       = ""
      install_strategy  = "Always"
      organization      = "default"
      release_name      = ""
      release_namespace = ""
      tags              = []
      upgrade_strategy  = "UpgradeOnly"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Add-ons Variable Map.  Add-ons Options are {ccp-monitor|kubernetes-dashboard} currently.
  * description - A description for the policy.
  * install_strategy - Addon install strategy to determine whether an addon is installed if not present.
    - None - Unspecified install strategy.
    - NoAction - No install action performed.
    - InstallOnly - Only install in green field. No action in case of failure or removal.
    - Always - Attempt install if chart is not already installed.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * release_name - Name for the helm release.
  * release_namespace - Namespace for the helm release.
  * tags - List of key/value Attributes to Assign to the Policy.
  * upgrade_strategy - Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.
    - None - Unspecified upgrade strategy.
    - NoAction - This choice enables No upgrades to be performed.
    - UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.
    - ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.
    - AlwaysReinstall - Always remove older release and reinstall.
  EOT
  type = map(object(
    {
      description       = optional(string)
      install_strategy  = optional(string)
      organization      = optional(string)
      release_name      = optional(string)
      release_namespace = optional(string)
      tags              = optional(list(map(string)))
      upgrade_strategy  = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Network CIDR Policy Variables
#______________________________________________

variable "k8s_network_cidr" {
  default = {
    default = { # The Network CIDR Policy Name will be {each.key}.  In this case it would be default if left like this.
      cidr_pod     = "100.64.0.0/16"
      cidr_service = "100.65.0.0/16"
      cni_type     = "Calico"
      description  = ""
      organization = "default"
      tags         = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Network CIDR Policy Variable Map.
  * cidr_pod - CIDR block to allocate pod network IP addresses from.
  * cidr_service - Pod CIDR Block to be used to assign Pod IP Addresses.
  * cni_type - Supported CNI type. Currently we only support Calico.
    - Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin
    - Aci - Cisco ACI Container Network Interface plugin.
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * tags - tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      cidr_pod     = optional(string)
      cidr_service = optional(string)
      cni_type     = optional(string)
      description  = optional(string)
      organization = optional(string)
      tags         = optional(list(map(string)))
    }
  ))
}


#______________________________________________
#
# Kubernetes Node OS Configuration Policy Variables
#______________________________________________

variable "k8s_nodeos_config" {
  default = {
    default = { # The Node OS Config Policy Name will be {each.key}.  In this case it would be default if left like this.
      description    = ""
      dns_servers_v4 = ["208.67.220.220", "208.67.222.222"]
      domain_name    = "example.com"
      ntp_servers    = []
      organization   = "default"
      tags           = []
      timezone       = "Etc/GMT"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Node OS Configuration Policy Variable Map.
  * description - A description for the policy.
  * dns_servers_v4 - DNS Servers for the Kubernetes Node OS Configuration Policy.
  * domain_name - Domain Name for the Kubernetes Node OS Configuration Policy.
  * ntp_servers - NTP Servers for the Kubernetes Node OS Configuration Policy.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * tags - tags - List of key/value Attributes to Assign to the Policy.
  * timezone - The timezone of the node's system clock.  For a List of supported timezones see the following URL. https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md.
  EOT
  type = map(object(
    {
      description    = optional(string)
      dns_servers_v4 = optional(list(string))
      domain_name    = optional(string)
      ntp_servers    = optional(list(string))
      organization   = optional(string)
      tags           = optional(list(map(string)))
      timezone       = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Runtime Policy Variables
#______________________________________________

variable "k8s_runtime_create" {
  default     = false
  description = "Flag to specify if the Kubernetes Runtime Policy should be created or not."
  type        = bool
}

variable "k8s_runtime_policies" {
  default = {
    default = { # The Addon Policy Name will be {each.key}.  In this case it would be default if left like this.
      description        = ""
      docker_bridge_cidr = ""
      docker_no_proxy    = []
      http_hostname      = ""
      http_port          = 8080
      http_protocol      = "http"
      http_username      = ""
      https_hostname     = ""
      https_port         = 8443
      https_protocol     = "https"
      https_username     = ""
      organization       = "default"
      tags               = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Runtime Policy Variable Map.
  * description - A description for the policy.
  * docker_bridge_cidr - The CIDR for docker bridge network. This address space must not collide with other CIDRs on your networks, including the cluster's service CIDR, pod CIDR and IP Pools.
  * docker_no_proxy - Docker no proxy list, when using internet proxy.
  * http_hostname - Hostname of the HTTP Proxy Server.
  * http_port - HTTP Proxy Port.  Range is 1-65535.
  * http_protocol - HTTP Proxy Protocol. Options are {http|https}.
  * http_username - Username for the HTTP Proxy Server.
  * https_hostname - Hostname of the HTTPS Proxy Server.
  * https_port - HTTPS Proxy Port.  Range is 1-65535
  * https_protocol - HTTPS Proxy Protocol. Options are {http|https}.
  * https_username - Username for the HTTPS Proxy Server.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      description        = optional(string)
      docker_bridge_cidr = optional(string)
      docker_no_proxy    = optional(list(string))
      http_hostname      = optional(string)
      http_port          = optional(number)
      http_protocol      = optional(string)
      http_username      = optional(string)
      https_hostname     = optional(string)
      https_port         = optional(number)
      https_protocol     = optional(string)
      https_username     = optional(string)
      organization       = optional(string)
      tags               = optional(list(map(string)))
    }
  ))
}

variable "k8s_runtime_http_password" {
  default     = ""
  description = "Password for the HTTP Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "k8s_runtime_https_password" {
  default     = ""
  description = "Password for the HTTPS Proxy Server, If required."
  sensitive   = true
  type        = string
}


#______________________________________________
#
# Kubernetes Trusted Registries Variables
#______________________________________________

variable "k8s_trusted_create" {
  default     = false
  description = "Flag to specify if the Kubernetes Runtime Policy should be created or not."
  type        = bool
}

variable "k8s_trusted_registries" {
  default = {
    default = { # The Trusted Registry Policy Name will be {each.key}.  In this case it would be default if left like this.
      description  = ""
      organization = "default"
      root_ca      = []
      tags         = []
      unsigned     = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Trusted Registry Policy Variable Map.
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * root_ca - List of root CA Signed Registries.
  * tags - List of key/value Attributes to Assign to the Policy.
  * unsigned - List of unsigned registries to be supported.
  EOT
  type = map(object(
    {
      description  = optional(string)
      organization = optional(string)
      root_ca      = optional(list(string))
      tags         = optional(list(map(string)))
      unsigned     = optional(list(string))
    }
  ))
}

#______________________________________________
#
# Kubernetes Version Variables
#______________________________________________

variable "k8s_version_policies" {
  default = {
    default = { # The K8S Version Policy Name will be {each.key}_v{each.version}.  In this case it would be default_v1.19.5 if left like this.
      description  = ""
      organization = "default"
      tags         = []
      version      = "1.19.5"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Version Policy Variable Map.
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  * version - Desired Kubernetes version.  Options are {1.19.5}
  EOT
  type = map(object(
    {
      description  = optional(string)
      organization = optional(string)
      tags         = optional(list(map(string)))
      version      = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Virtual Machine Infra Variables
#______________________________________________

variable "k8s_vm_infra_config" {
  default = {
    default = { # The VM Infra Config Policy Name will be {each.key}.  In this case it would be default if left like this.
      description           = ""
      organization          = "default"
      tags                  = []
      vsphere_cluster       = "default"
      vsphere_datastore     = "datastore1"
      vsphere_portgroup     = ["VM Network"]
      vsphere_resource_pool = ""
      vsphere_target        = ""
    }
  }
  description = <<-EOT
  Intersight Kubernetes Virtual Machine Infra Config Policy Variable Map.
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  * vsphere_cluster - vSphere Cluster to assign the K8S Cluster Deployment.
  * vsphere_datastore - vSphere Datastore to assign the K8S Cluster Deployment.r\n
  * vsphere_portgroup - vSphere Port Group to assign the K8S Cluster Deployment.r\n
  * vsphere_resource_pool - vSphere Resource Pool to assign the K8S Cluster Deployment.r\n
  * vsphere_target - Name of the vSphere Target discovered in Intersight, to provision the cluster on.
  EOT
  type = map(object(
    {
      description           = optional(string)
      organization          = optional(string)
      tags                  = optional(list(map(string)))
      vsphere_cluster       = string
      vsphere_datastore     = string
      vsphere_portgroup     = list(string)
      vsphere_resource_pool = optional(string)
      vsphere_target        = string
    }
  ))
}

variable "k8s_vm_infra_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}


#______________________________________________
#
# Kubernetes Virtual Machine Instance Variables
#______________________________________________

variable "k8s_vm_instance_type" {
  default = {
    default = { # The VM Instance Type Policy Name will be {each.key}.  In this case it would be default if left like this.
      cpu          = 4
      description  = ""
      disk         = 40
      memory       = 16384
      organization = "default"
      tags         = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Node OS Configuration Policy Variable Map.  Name of the policy will be {organization}_{each.key}.
  * cpu - Number of CPUs allocated to virtual machine.  Range is 1-40.
  * description - A description for the policy.
  * disk - Ephemeral disk capacity to be provided with units example - 10 for 10 Gigabytes.
  * memory - Virtual machine memory defined in mebibytes (MiB).  Range is 1-4177920.
  * organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      cpu          = optional(number)
      description  = optional(string)
      disk         = optional(number)
      memory       = optional(number)
      organization = optional(string)
      tags         = optional(list(map(string)))
    }
  ))
}
