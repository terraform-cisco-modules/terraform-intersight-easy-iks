#__________________________________________________________
#
# Create Intersight Tenant IP Pools
#__________________________________________________________

module "ip_pools" {
  depends_on = [
    data.intersight_organization_organization.org_moid
  ]
  source           = "terraform-cisco-modules/imm/intersight//modules/pools_ip"
  for_each         = local.ip_pools
  assignment_order = "sequential"
  description      = "${var.tenant_name} IP Pool."
  dns_servers_v4   = var.dns_servers_v4
  name             = each.value.name != "" ? each.value.name : "${var.tenant_name}_ip_pool"
  org_moid         = local.org_moid
  tags             = each.value.tags != [] ? each.value.tags : var.tags != [] ? var.tags : []
  ipv4_block = [
    {
      pool_size   = each.value.size
      starting_ip = join(".", [
        tostring(element(split(".", each.value.gateway), 0)), tostring(
          element(split(".", each.value.gateway), 1)), tostring(
          element(split(".", each.value.gateway), 2)), tostring(each.value.from)])
    }
  ]
  ipv4_config = [
    {
      gateway = element(split("/", each.value.gateway), 0)
      netmask = element(split("/", each.value.gateway), 1) == "1" ? "128.0.0.0" : element(
        split("/", each.value.gateway), 1) == "2" ? "192.0.0.0" : element(
        split("/", each.value.gateway), 1) == "3" ? "224.0.0.0" : element(
        split("/", each.value.gateway), 1) == "4" ? "240.0.0.0" : element(
        split("/", each.value.gateway), 1) == "5" ? "248.0.0.0" : element(
        split("/", each.value.gateway), 1) == "6" ? "252.0.0.0" : element(
        split("/", each.value.gateway), 1) == "7" ? "254.0.0.0" : element(
        split("/", each.value.gateway), 1) == "8" ? "255.0.0.0" : element(
        split("/", each.value.gateway), 1) == "9" ? "255.128.0.0" : element(
        split("/", each.value.gateway), 1) == "10" ? "255.192.0.0" : element(
        split("/", each.value.gateway), 1) == "11" ? "255.224.0.0" : element(
        split("/", each.value.gateway), 1) == "12" ? "255.240.0.0" : element(
        split("/", each.value.gateway), 1) == "13" ? "255.248.0.0" : element(
        split("/", each.value.gateway), 1) == "14" ? "255.252.0.0" : element(
        split("/", each.value.gateway), 1) == "15" ? "255.254.0.0" : element(
        split("/", each.value.gateway), 1) == "16" ? "255.255.0.0" : element(
        split("/", each.value.gateway), 1) == "17" ? "255.255.128.0" : element(
        split("/", each.value.gateway), 1) == "18" ? "255.255.192.0" : element(
        split("/", each.value.gateway), 1) == "19" ? "255.255.224.0" : element(
        split("/", each.value.gateway), 1) == "20" ? "255.255.240.0" : element(
        split("/", each.value.gateway), 1) == "21" ? "255.255.248.0" : element(
        split("/", each.value.gateway), 1) == "22" ? "255.255.252.0" : element(
        split("/", each.value.gateway), 1) == "23" ? "255.255.254.0" : element(
        split("/", each.value.gateway), 1) == "24" ? "255.255.255.0" : element(
        split("/", each.value.gateway), 1) == "25" ? "255.255.255.128" : element(
        split("/", each.value.gateway), 1) == "26" ? "255.255.255.192" : element(
        split("/", each.value.gateway), 1) == "27" ? "255.255.255.224" : element(
        split("/", each.value.gateway), 1) == "28" ? "255.255.255.240" : "255.255.255.248"
    }
  ]
}


#__________________________________________________________
#
# Create Intersight Kubernetes Policies
#__________________________________________________________

#______________________________________________
#
# Kubernetes Runtime Policy Module
#______________________________________________

module "k8s_runtime_policy" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  count                = var.k8s_runtime.http_hostname != "" && var.k8s_runtime.https_hostname != "" ? 1 : 0
  docker_no_proxy      = var.k8s_runtime.docker_no_proxy
  org_name             = var.organization
  name                 = var.k8s_runtime.name != null ? var.k8s_runtime.name : "${var.tenant_name}_runtime"
  proxy_http_hostname  = var.k8s_runtime.http_hostname
  proxy_http_port      = var.k8s_runtime.http_port
  proxy_http_password  = var.k8s_runtime_http_password
  proxy_http_protocol  = var.k8s_runtime.http_protocol
  proxy_http_username  = var.k8s_runtime.http_username
  proxy_https_hostname = var.k8s_runtime.https_hostname != "" ? var.k8s_runtime.https_hostname : var.k8s_runtime.http_hostname
  proxy_https_password = var.k8s_runtime_https_password
  proxy_https_port     = var.k8s_runtime.https_port
  proxy_https_protocol = var.k8s_runtime.https_protocol
  proxy_https_username = var.k8s_runtime.https_username != "" ? var.k8s_runtime.https_username : var.k8s_runtime.http_username
  tags                 = var.k8s_runtime.tags != [] ? var.k8s_runtime.tags : var.tags
}

#______________________________________________
#
# Kubernetes Trusted Registry Policy Module
#______________________________________________

module "k8s_trusted_registry" {
  count               = var.k8s_trusted_registry.root_ca != null || var.k8s_trusted_registry.unsigned != null ? 1 : 0
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  org_name            = var.organization
  policy_name         = var.k8s_trusted_registry.name     != null ? var.k8s_trusted_registry.name     : "${var.tenant_name}_registry"
  root_ca_registries  = var.k8s_trusted_registry.root_ca  != null ? var.k8s_trusted_registry.root_ca  : []
  unsigned_registries = var.k8s_trusted_registry.unsigned != null ? var.k8s_trusted_registry.unsigned : []
  tags                = var.k8s_trusted_registry.tags     != null ? var.k8s_trusted_registry.tags     : var.tags != [] ? var.tags : []
}


#______________________________________________
#
# Kubernetes Version Policy Module
#______________________________________________

module "k8s_version_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  for_each         = local.k8s_version
  org_name         = var.organization
  k8s_version_name = each.value.name != "" ? each.value.name : "${var.tenant_name}_version"
  k8s_version      = each.value.version
  tags             = each.value.tags != [] ? each.value.tags : var.tags
}


#______________________________________________
#
# Kubernetes Virtual Machine Infra Config
#______________________________________________

module "k8s_vm_infra_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  for_each         = local.k8s_vm_infra
  device_name      = each.value.vsphere_target
  name             = each.value.name != "" ? each.value.name : "${var.tenant_name}_vm_infra"
  org_name         = var.organization
  tags             = each.value.tags != null ? each.value.tags : var.tags
  vc_password      = var.k8s_vm_infra_password
  vc_cluster       = each.value.vsphere_cluster
  vc_datastore     = each.value.vsphere_datastore
  vc_portgroup     = each.value.vsphere_portgroup
  vc_resource_pool = each.value.vsphere_resource_pool
}


#______________________________________________
#
# Create the Kubernetes VM Instance Type Policies
# * Small
# * Medium
# * Large
#______________________________________________

module "k8s_vm_instance_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  for_each  = local.k8s_vm_instance
  cpu       = each.value.small_cpu
  disk_size = each.value.small_disk
  memory    = each.value.small_memory
  name      = "${var.tenant_name}_small"
  org_name  = var.organization
  tags      = each.value.tags != [] ? each.value.tags : var.tags
}

module "k8s_vm_instance_medium" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  for_each  = local.k8s_vm_instance
  cpu       = each.value.medium_cpu
  disk_size = each.value.medium_disk
  memory    = each.value.medium_memory
  name      = "${var.tenant_name}_medium"
  org_name  = var.organization
  tags      = each.value.tags != [] ? each.value.tags : var.tags
}

module "k8s_vm_instance_large" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  for_each  = local.k8s_vm_instance
  cpu       = each.value.large_cpu
  disk_size = each.value.large_disk
  memory    = each.value.large_memory
  name      = "${var.tenant_name}_large"
  org_name  = var.organization
  tags      = each.value.tags != [] ? each.value.tags : var.tags
}

#______________________________________________
#
# Create the Kubernetes VM Node OS Config
#______________________________________________

module "k8s_vm_network_policy" {
  source       = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  for_each     = local.k8s_vm_network
  cni          = each.value.cni
  org_name     = var.organization
  policy_name  = each.value.name != "" ? each.value.name : "${var.tenant_name}_vm_network"
  dns_servers  = var.dns_servers_v4
  domain_name  = var.domain_name
  ntp_servers  = var.ntp_servers != [] ? var.ntp_servers : var.dns_servers_v4
  pod_cidr     = each.value.cidr_pod
  service_cidr = each.value.cidr_service
  timezone     = var.timezone
  tags         = each.value.tags != null ? each.value.tags : var.tags
}


