locals {
  # Intersight Organization Variables
  org_name = var.organization
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
      ssh_key                         = v.ssh_key
      ssh_user                        = (v.ssh_user != null ? v.ssh_user : "iksadmin")
      tags                            = (v.tags != null ? v.tags : [])
      wait_for_complete               = (v.wait_for_complete != null ? v.wait_for_complete : false)
      worker_desired_size             = (v.worker_desired_size != null ? v.worker_desired_size : 1)
      worker_k8s_labels               = (v.worker_k8s_labels != null ? v.worker_k8s_labels : [])
      worker_max_size                 = (v.worker_max_size != null ? v.worker_max_size : 4)
    }
  }
  ip_pools = {
    for k, v in var.ip_pools : k => {
      description = (v.description != null ? v.description : "")
      from        = (v.from != null ? v.from : 20)
      gateway     = (v.gateway != null ? v.gateway : "198.18.0.1/24")
      name        = (v.name != null ? v.name : "")
      size        = (v.size != null ? v.size : 30)
      tags        = (v.tags != null ? v.tags : [])
    }
  }
  k8s_addon_policies = {
    for k, v in var.k8s_addon_policies : k => {
      description       = (v.description != null ? v.description : "")
      install_strategy  = (v.install_strategy != null ? v.install_strategy : "Always")
      name              = (v.name != null ? v.name : "")
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
      name         = (v.name != null ? v.name : "")
      tags         = (v.tags != null ? v.tags : [])
    }
  }
  k8s_nodeos_config = {
    for k, v in var.k8s_nodeos_config : k => {
      description    = (v.description != null ? v.description : "")
      dns_servers_v4 = (v.dns_servers_v4 != null ? v.dns_servers_v4 : ["208.67.220.220", "208.67.222.222"])
      domain_name    = (v.domain_name != null ? v.domain_name : "example.com")
      ntp_servers    = (v.ntp_servers != null ? v.ntp_servers : [])
      name           = (v.name != null ? v.name : "")
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
      name               = (v.name != null ? v.name : "")
      tags               = (v.tags != null ? v.tags : [])
    }
  }
  k8s_trusted_registries = {
    for k, v in var.k8s_trusted_registries : k => {
      description = (v.description != null ? v.description : "")
      name        = (v.name != null ? v.name : "")
      root_ca     = (v.root_ca != null ? v.root_ca : [])
      tags        = (v.tags != null ? v.tags : [])
      unsigned    = (v.unsigned != null ? v.unsigned : [])
    }
  }
  k8s_version_policies = {
    for k, v in var.k8s_version_policies : k => {
      description = (v.description != null ? v.description : "")
      name        = (v.name != null ? v.name : "")
      tags        = (v.tags != null ? v.tags : [])
      version     = (v.version != null ? v.version : "1.19.5")
    }
  }
  k8s_vm_infra_config = {
    for k, v in var.k8s_vm_infra_config : k => {
      description           = (v.description != null ? v.description : "")
      name                  = (v.name != null ? v.name : "")
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
      description = (v.description != null ? v.description : "")
      cpu         = (v.cpu != null ? v.cpu : 4)
      disk        = (v.disk != null ? v.disk : 40)
      memory      = (v.memory != null ? v.memory : 16384)
      tags        = (v.tags != null ? v.tags : [])
    }
  }
}


#______________________________________________
#
# DNS Variables
#______________________________________________

variable "dns_servers_v4" {
  default     = ["198.18.0.100", "198.18.0.101"]
  description = "DNS Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}

#__________________________________________________________
#
# Required Variables
#__________________________________________________________

variable "tenant_name" {
  default     = "default"
  description = "Tenant Name for Workspace Creation in Terraform Cloud and IKS Cluster Naming."
  type        = string
}

variable "tags" {
  default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = list(map(string))
}

#______________________________________________
#
# IP Pool Variables
#______________________________________________

variable "ip_pools" {
  default = {
    default = {
      description = ""
      from        = 20
      gateway     = "198.18.0.1/24"
      name        = "{tenant_name}_ip_pool"
      size        = 30
      tags        = []
    }
  }
  description = "Intersight IP Pool Variable Map.\r\n1. description - A description for the policy.\r\n2. from - host address of the pool starting address.\r\n3. gateway - ip/prefix of the gateway.\r\n4. name - Name of the IP Pool.\r\n5. size - Number of host addresses to assign to the pool.\r\n6. tags - List of key/value Attributes to Assign to the Policy.\r\n"
  type = map(object(
    {
      description = optional(string)
      from        = optional(number)
      gateway     = optional(string)
      name        = optional(string)
      size        = optional(number)
      tags        = optional(list(map(string)))
    }
  ))
}

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
    default = {
      description       = ""
      install_strategy  = "Always"
      name              = "{tenant_name}_{each.key}"
      release_name      = ""
      release_namespace = ""
      tags              = []
      upgrade_strategy  = "UpgradeOnly"
    }
  }
  description = "Intersight Kubernetes Service Add-ons Variable Map.  Add-ons Options are {ccp-monitor|kubernetes-dashboard} currently.\r\n1. description - A description for the policy.\r\n2. install_strategy - Addon install strategy to determine whether an addon is installed if not present.\r\n * None - Unspecified install strategy.\r\n * NoAction - No install action performed.\r\n * InstallOnly - Only install in green field. No action in case of failure or removal.\r\n * Always - Attempt install if chart is not already installed.\r\n3. name - Name of the concrete policy.\r\n4. release_name - Name for the helm release.\r\n5. release_namespace - Namespace for the helm release.\r\n6. tags - List of key/value Attributes to Assign to the Policy.\r\n7. upgrade_strategy - Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.\r\n * None - Unspecified upgrade strategy.\r\n * NoAction - This choice enables No upgrades to be performed.\r\n * UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.\r\n * ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.\r\n * AlwaysReinstall - Always remove older release and reinstall."
  type = map(object(
    {
      description       = optional(string)
      install_strategy  = optional(string)
      name              = optional(string)
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
    default = {
      cidr_pod     = "100.64.0.0/16"
      cidr_service = "100.65.0.0/16"
      cni_type     = "Calico"
      description  = ""
      name         = "{tenant_name}_network_cidr"
      tags         = []
    }
  }
  description = "Intersight Kubernetes Network CIDR Policy Variable Map.\r\n1. cidr_pod - CIDR block to allocate pod network IP addresses from.\r\n2. cidr_service - Pod CIDR Block to be used to assign Pod IP Addresses.\r\n3. cni_type - Supported CNI type. Currently we only support Calico.\r\n* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin.\r\n* Aci - Cisco ACI Container Network Interface plugin.\r\n4. description - A description for the policy.\r\n5. name - Name of the concrete policy.\r\n6. tags - tags - List of key/value Attributes to Assign to the Policy."
  type = map(object(
    {
      cidr_pod     = optional(string)
      cidr_service = optional(string)
      cni_type     = optional(string)
      description  = optional(string)
      name         = optional(string)
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
    default = {
      description    = ""
      dns_servers_v4 = ["208.67.220.220", "208.67.222.222"]
      domain_name    = "example.com"
      ntp_servers    = []
      name           = "{tenant_name}_nodeos_config"
      tags           = []
      timezone       = "Etc/GMT"
    }
  }
  description = "Intersight Kubernetes Node OS Configuration Policy Variable Map.\r\n1. description - A description for the policy.\r\n2. dns_servers_v4 - DNS Servers for the Kubernetes Node OS Configuration Policy.\r\n3. domain_name - Domain Name for the Kubernetes Node OS Configuration Policy.\r\n4. ntp_servers - NTP Servers for the Kubernetes Node OS Configuration Policy.\r\n5. name - Name of the concrete policy.\r\n6. tags - tags - List of key/value Attributes to Assign to the Policy.\r\n7. timezone - The timezone of the node's system clock.  For a List of supported timezones see the following URL.\r\n https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md."
  type = map(object(
    {
      description    = optional(string)
      dns_servers_v4 = optional(list(string))
      domain_name    = optional(string)
      ntp_servers    = optional(list(string))
      name           = optional(string)
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
    default = {
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
      name               = "{tenant_name}_runtime"
      tags               = []
    }
  }
  description = "Intersight Kubernetes Runtime Policy Variable Map.\r\n1. description - A description for the policy.\r\n2. docker_bridge_cidr - The CIDR for docker bridge network. This address space must not collide with other CIDRs on your networks, including the cluster's service CIDR, pod CIDR and IP Pools.\r\n3. docker_no_proxy - Docker no proxy list, when using internet proxy.\r\n4. http_hostname - Hostname of the HTTP Proxy Server.\r\n5. http_port - HTTP Proxy Port.  Range is 1-65535.\r\n6. http_protocol - HTTP Proxy Protocol. Options are {http|https}.\r\n7. http_username - Username for the HTTP Proxy Server.\r\n8. https_hostname - Hostname of the HTTPS Proxy Server.\r\n9. https_port - HTTPS Proxy Port.  Range is 1-65535\r\n10. https_protocol - HTTPS Proxy Protocol. Options are {http|https}.\r\n11. https_username - Username for the HTTPS Proxy Server.\r\n12. name - Name of the concrete policy.\r\n13. tags - List of key/value Attributes to Assign to the Policy."
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
      name               = optional(string)
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
    default = {
      description = ""
      name        = "{tenant_name}_registry"
      root_ca     = []
      tags        = []
      unsigned    = []
    }
  }
  description = "Intersight Kubernetes Trusted Registry Policy Variable Map.\r\n1. description - A description for the policy.\r\n2. name - Name of the concrete policy.\r\n3. root_ca - List of root CA Signed Registries.\r\n4. tags - List of key/value Attributes to Assign to the Policy.\r\n5. unsigned - List of unsigned registries to be supported."
  type = map(object(
    {
      description = optional(string)
      name        = optional(string)
      root_ca     = optional(list(string))
      tags        = optional(list(map(string)))
      unsigned    = optional(list(string))
    }
  ))
}

#______________________________________________
#
# Kubernetes Version Variables
#______________________________________________

variable "k8s_version_policies" {
  default = {
    default = {
      description = ""
      name        = "{tenant_name}_v{each.value.version}"
      tags        = []
      version     = "1.19.5"
    }
  }
  description = "Intersight Kubernetes Version Policy Variable Map.\r\n1. description - A description for the policy.\r\n2. name - Name of the concrete policy.\r\n3. tags - List of key/value Attributes to Assign to the Policy.\r\n4. version - Desired Kubernetes version.  Options are {1.19.5}"
  type = map(object(
    {
      description = optional(string)
      name        = optional(string)
      tags        = optional(list(map(string)))
      version     = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Virtual Machine Infra Variables
#______________________________________________

variable "k8s_vm_infra_config" {
  default = {
    default = {
      description           = ""
      name                  = "{tenant_name}_vm_infra"
      tags                  = []
      vsphere_cluster       = "default"
      vsphere_datastore     = "datastore1"
      vsphere_portgroup     = ["VM Network"]
      vsphere_resource_pool = ""
      vsphere_target        = ""
    }
  }
  description = "Intersight Kubernetes Virtual Machine Infra Config Policy Variable Map.\r\n\r\n1. description - A description for the policy.\r\n2. name - Name of the concrete policy.\r\n3. tags - List of key/value Attributes to Assign to the Policy.\r\n4. vsphere_cluster - vSphere Cluster to assign the K8S Cluster Deployment.\r\n5. vsphere_datastore - vSphere Datastore to assign the K8S Cluster Deployment.r\n6. vsphere_portgroup - vSphere Port Group to assign the K8S Cluster Deployment.r\n7. vsphere_resource_pool - vSphere Resource Pool to assign the K8S Cluster Deployment.r\n8. vsphere_target - Name of the vSphere Target discovered in Intersight, to provision the cluster on."
  type = map(object(
    {
      description           = optional(string)
      name                  = optional(string)
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
    default = {
      cpu         = 4
      description = ""
      disk        = 40
      memory      = 16384
      tags        = []
    }
  }
  description = "Intersight Kubernetes Node OS Configuration Policy Variable Map.  Name of the policy will be {tenant_name}_{each.key}.\r\n1. cpu - Number of CPUs allocated to virtual machine.  Range is 1-40.\r\n2. description - A description for the policy.\r\n3. disk - Ephemeral disk capacity to be provided with units example - 10 for 10 Gigabytes.\r\n4. memory - Virtual machine memory defined in mebibytes (MiB).  Range is 1-4177920.\r\n5. tags - List of key/value Attributes to Assign to the Policy."
  type = map(object(
    {
      cpu         = optional(number)
      description = optional(string)
      disk        = optional(number)
      memory      = optional(number)
      tags        = optional(list(map(string)))
    }
  ))
}


#__________________________________________________________
#
# Intersight Kubernetes Service Cluster Variables
#__________________________________________________________

#______________________________________________
#
# IKS Cluster Variables
#______________________________________________

variable "iks_cluster" {
  default = {
    default = {
      action_cluster                  = "Deploy"
      action_control_plane            = "No-op"
      action_worker                   = "No-op"
      control_plane_desired_size      = 1
      control_plane_k8s_labels        = []
      control_plane_max_size          = 3
      description                     = ""
      ip_pool_moid                    = "**REQUIRED**"
      k8s_addon_policy_moid           = []
      k8s_network_cidr_moid           = "**REQUIRED**"
      k8s_nodeos_config_moid          = "**REQUIRED**"
      k8s_registry_moid               = ""
      k8s_runtime_moid                = ""
      k8s_version_moid                = "**REQUIRED**"
      k8s_vm_infra_moid               = "**REQUIRED**"
      k8s_vm_instance_type_ctrl_plane = "**REQUIRED**"
      k8s_vm_instance_type_worker     = "**REQUIRED**"
      load_balancers                  = 3
      ssh_key                         = "ssh_key_1"
      ssh_user                        = "iksadmin"
      tags                            = []
      wait_for_complete               = false
      worker_desired_size             = 0
      worker_k8s_labels               = []
      worker_max_size                 = 4
    }
  }
  description = "Intersight Kubernetes Service Cluster Profile Variable Map.\r\n1. action_cluster - Action to perform on the Kubernetes Cluster.  Options are {Delete|Deploy|Ready|No-op|Unassign}.\r\n2. action_control_plane - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.\r\n3. action_worker - Action to perform on the Kubernetes Worker Nodes.  Options are {Delete|Deploy|Ready|No-op|Unassign}.\r\n4. control_plane_desired_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1|3}.\r\n5. control_plane_k8s_labels - List of key/value Attributes to Assign to the control plane node configuration.\r\n6. control_plane_max_size - Maximum number of control plane nodes desired in this node group.  Range is 1-128.\r\n7. description - A description for the policy.\r\n8. ip_pool_moid - Name of the IP Pool to assign to Cluster and Node Profiles.\r\n9. k8s_addon_policy_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor|kubernetes-dashboard} or [].\r\n10. k8s_network_cidr_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.\r\n11. k8s_nodeos_config_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.\r\n12. k8s_registry_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles\r\n.13. k8s_runtime_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles\r\n.14. k8s_version_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.\r\n15. k8s_vm_infra_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.\r\n16. k8s_vm_instance_type_ctrl_plane - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.\r\n17. k8s_vm_instance_type_worker - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to worker nodes.\r\n18. load_balancers - Number of load balancer addresses to deploy. Range is 1-999.\r\n19. ssh_key - The SSH Key Name should be ssh_key_{1|2|3|4|5}.  This will point to the ssh_key variable that will be used.\r\n20. ssh_user - SSH Username for node login.\r\n21. tags - tags - List of key/value Attributes to Assign to the Profile.\r\n22. wait_for_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.\r\n23. worker_desired_size - Desired number of nodes in this worker node group, same as minsize initially and is updated by the auto-scaler.  Range is 1-128.\r\n24. worker_k8s_labels - List of key/value Attributes to Assign to the worker node configuration.\r\n25. worker_max_size - Maximum number of worker nodes desired in this node group.  Range is 1-128.\r\n"
  type = map(object(
    {
      action_cluster                  = optional(string)
      action_control_plane            = optional(string)
      action_worker                   = optional(string)
      control_plane_desired_size      = optional(number)
      control_plane_k8s_labels        = optional(list(map(string)))
      control_plane_max_size          = optional(number)
      description                     = optional(string)
      ip_pool_moid                    = string
      k8s_addon_policy_moid           = optional(set(string))
      k8s_network_cidr_moid           = string
      k8s_nodeos_config_moid          = string
      k8s_registry_moid               = optional(string)
      k8s_runtime_moid                = optional(string)
      k8s_version_moid                = string
      k8s_vm_infra_moid               = string
      k8s_vm_instance_type_ctrl_plane = string
      k8s_vm_instance_type_worker     = string
      load_balancers                  = optional(number)
      ssh_key                         = string
      ssh_user                        = string
      tags                            = optional(list(map(string)))
      wait_for_complete               = optional(bool)
      worker_desired_size             = optional(number)
      worker_k8s_labels               = optional(list(map(string)))
      worker_max_size                 = optional(number)
    }
  ))
}

variable "ssh_key_1" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 1."
  sensitive   = true
  type        = string
}

variable "ssh_key_2" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_3" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_4" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_key_5" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters."
  sensitive   = true
  type        = string
}


#__________________________________________________________
#
# Terraform Cloud Workspaces
#__________________________________________________________

module "iks_workspace" {
  source            = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  auto_apply        = true
  description       = "Intersight Kubernetes Service Workspace."
  name              = var.tenant_name
  terraform_version = var.terraform_version
  tfc_oath_token    = var.tfc_oath_token
  tfc_org_name      = var.tfc_organization
  vcs_repo          = var.vcs_repo
  working_directory = "modules/iks"
}

output "iks_workspace" {
  description = "Terraform Cloud IKS Workspace ID(s)."
  value       = module.iks_workspace.workspace.id
}

#__________________________________________________________
#
# Terraform Cloud Workspace Variables: iks
#__________________________________________________________

module "iks_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.iks_workspace
  ]
  category     = "terraform"
  workspace_id = module.iks_workspace.workspace.id
  variable_list = {
    #---------------------------
    # Intersight Variables
    #---------------------------
    apikey = {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    endpoint = {
      description = "Intersight API Key."
      key         = "endpoint"
      value       = var.endpoint
    },
    secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    },
    #---------------------------
    # K8S Policy Variables
    #---------------------------
    dns_servers_v4 = {
      description = "DNS Servers for the IP Pools."
      hcl         = true
      key         = "dns_servers_v4"
      value       = "[${join(",", [for s in var.dns_servers_v4 : format("%q", s)])}]"
    },
    tenant_name = {
      description = "Tenant Name."
      key         = "tenant_name"
      value       = var.tenant_name
    },
    tags = {
      description = "Intersight Tags for Poliices and Profiles."
      hcl         = false
      key         = "tags"
      value       = "${jsonencode(var.tags)}"
    },
    ip_pools = {
      description = "${var.tenant_name} IP Pools."
      hcl         = false
      key         = "ip_pools"
      value       = "${jsonencode(var.ip_pools)}"
    },
    k8s_addon_policies = {
      description = "${var.tenant_name} Addons Policies."
      hcl         = false
      key         = "k8s_addon_policies"
      value       = "${jsonencode(var.k8s_addon_policies)}"
    },
    k8s_network_cidr = {
      description = "${var.tenant_name} Kubernetes Network CIDR Policy Variables."
      hcl         = false
      key         = "k8s_network_cidr"
      value       = "${jsonencode(var.k8s_network_cidr)}"
    },
    k8s_nodeos_config = {
      description = "${var.tenant_name} Kubernetes Node OS Configuration Policy Variables."
      hcl         = false
      key         = "k8s_nodeos_config"
      value       = "${jsonencode(var.k8s_nodeos_config)}"
    },
    k8s_runtime_create = {
      description = "${var.tenant_name} Kubernetes Runtime Policy Create Option."
      key         = "k8s_runtime_create"
      value       = var.k8s_runtime_create
    },
    k8s_runtime_policies = {
      description = "${var.tenant_name} Kubernetes Runtime Policy Variables."
      hcl         = false
      key         = "k8s_runtime_policies"
      value       = "${jsonencode(var.k8s_runtime_policies)}"
    },
    k8s_trusted_create = {
      description = "${var.tenant_name} Kubernetes Trusted Registry Policy Create Option."
      key         = "k8s_trusted_create"
      value       = var.k8s_trusted_create
    },
    k8s_trusted_registries = {
      description = "${var.tenant_name} Kubernetes Trusted Registry Policy Variables."
      hcl         = false
      key         = "k8s_trusted_registries"
      value       = "${jsonencode(var.k8s_trusted_registries)}"
    },
    k8s_version_policies = {
      description = "${var.tenant_name} Kubernetes Version Policy Variables."
      hcl         = false
      key         = "k8s_version_policies"
      value       = "${jsonencode(var.k8s_version_policies)}"
    },
    k8s_vm_infra_config = {
      description = "${var.tenant_name} Kubernetes VIrtual Machine Infra Config Policy Variables."
      hcl         = false
      key         = "k8s_vm_infra_config"
      value       = "${jsonencode(var.k8s_vm_infra_config)}"
    },
    k8s_vm_infra_password = {
      description = "VIrtual Center Password."
      key         = "k8s_vm_infra_password"
      sensitive   = true
      value       = "var.k8s_vm_infra_password"
    }
    k8s_vm_instance_type = {
      description = "${var.tenant_name} Kubernetes Virtual Machine Instance Policy Variables."
      hcl         = false
      key         = "k8s_vm_instance_type"
      value       = "${jsonencode(var.k8s_vm_instance_type)}"
    },
    #---------------------------
    # IKS Cluster Variables
    #---------------------------
    iks_cluster = {
      description = "${var.tenant_name} IKS Clusters."
      hcl         = false
      key         = "iks_cluster"
      value       = "${jsonencode(var.iks_cluster)}"
    },
    ssh_key_1 = {
      description = "SSH Key Variable 1."
      key         = "ssh_key_1"
      sensitive   = true
      value       = var.ssh_key_1
    },
    ssh_key_2 = {
      description = "SSH Key Variable 2."
      key         = "ssh_key_2"
      sensitive   = true
      value       = var.ssh_key_2
    },
    ssh_key_3 = {
      description = "SSH Key Variable 3."
      key         = "ssh_key_3"
      sensitive   = true
      value       = var.ssh_key_3
    },
    ssh_key_4 = {
      description = "SSH Key Variable 4."
      key         = "ssh_key_4"
      sensitive   = true
      value       = var.ssh_key_4
    },
    ssh_key_5 = {
      description = "SSH Key Variable 5."
      key         = "ssh_key_5"
      sensitive   = true
      value       = var.ssh_key_5
    },
  }
}
