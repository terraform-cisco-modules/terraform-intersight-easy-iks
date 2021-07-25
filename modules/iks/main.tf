#__________________________________________________________
#
# Get Outputs from the Global Variables Workspace
#__________________________________________________________

# data "terraform_remote_state" "tenant" {
#   backend = "remote"
#   config = {
#     organization = var.tfc_organization
#     workspaces = {
#       name = var.ws_tenant
#     }
#   }
# }


#__________________________________________________________
#
# Assign Global Attributes from tenant Workspace
#__________________________________________________________

#__________________________________________________________
#
# Intersight Organization moid
#__________________________________________________________

data "intersight_organization_organization" "organization_moid" {
  name = var.organization
}


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
      pool_size = each.value.size
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

#_____________________________________________________
#
# Configure Add-Ons Policy for the Kubernetes Cluster
#_____________________________________________________

module "k8s_addons" {
  source           = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_addons"
  for_each         = local.k8s_addons
  addon            = each.key
  description      = "${var.tenant_name} Addons Policy for ${each.key}"
  install_strategy = each.value.install_strategy
  name             = each.value.name != "" ? each.value.name : "${var.tenant_name}_${each.key}"
  org_moid         = local.org_moid
  release_name     = each.value.release_name
  upgrade_strategy = each.value.upgrade_strategy
  tags             = each.value.tags != [] ? each.value.tags : var.tags
}


#______________________________________________
#
# Kubernetes Runtime Policy Module
#______________________________________________

module "k8s_runtime_policies" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  for_each             = var.k8s_runtime_create == true ? local.k8s_runtime : {}
  docker_no_proxy      = each.value.docker_no_proxy
  org_name             = var.organization
  name                 = each.value.name != "" ? each.value.name : "${var.tenant_name}_runtime"
  proxy_http_hostname  = each.value.http_hostname
  proxy_http_port      = each.value.http_port
  proxy_http_password  = var.k8s_runtime_http_password
  proxy_http_protocol  = each.value.http_protocol
  proxy_http_username  = each.value.http_username
  proxy_https_hostname = each.value.https_hostname != "" ? each.value.https_hostname : each.value.http_hostname
  proxy_https_password = var.k8s_runtime_https_password
  proxy_https_port     = each.value.https_port
  proxy_https_protocol = each.value.https_protocol
  proxy_https_username = each.value.https_username != "" ? each.value.https_username : each.value.http_username
  tags                 = each.value.tags != [] ? each.value.tags : var.tags
}


#______________________________________________
#
# Kubernetes Trusted Registry Policy Module
#______________________________________________

module "k8s_trusted_registries" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  for_each            = var.k8s_trusted_create == true ? local.k8s_trusted_registry : {}
  org_name            = var.organization
  policy_name         = each.value.name != "" ? each.value.name : "${var.tenant_name}_registry"
  root_ca_registries  = each.value.root_ca != [] ? each.value.root_ca : []
  unsigned_registries = each.value.unsigned != [] ? each.value.unsigned : []
  tags                = each.value.tags != [] ? each.value.tags : var.tags
}


#______________________________________________
#
# Kubernetes Version Policy Module
#______________________________________________

module "k8s_version_policies" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  for_each         = local.k8s_version
  org_name         = var.organization
  k8s_version_name = each.value.name != "" ? "${each.value.name}_v${each.value.version}" : "${var.tenant_name}_v${each.value.version}"
  k8s_version      = each.value.version
  tags             = each.value.tags != [] ? each.value.tags : var.tags
}


#______________________________________________
#
# Kubernetes Virtual Machine Infra Config
#______________________________________________

module "k8s_vm_infra_policies" {
  source                = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_vm_infra"
  for_each              = local.k8s_vm_infra
  description           = "${var.tenant_name} Virtual Machine Infra Config Policy."
  name                  = each.value.name != "" ? each.value.name : "${var.tenant_name}_vm_infra"
  org_moid              = local.org_moid
  tags                  = each.value.tags != null ? each.value.tags : var.tags
  vsphere_password      = var.k8s_vm_infra_password
  vsphere_cluster       = each.value.vsphere_cluster
  vsphere_datastore     = each.value.vsphere_datastore
  vsphere_portgroup     = each.value.vsphere_portgroup
  vsphere_resource_pool = each.value.vsphere_resource_pool
  vsphere_target        = each.value.vsphere_target
}


#______________________________________________
#
# Create the Kubernetes VM Instance Types
#______________________________________________

module "k8s_vm_instance" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  for_each  = local.k8s_vm_instance
  cpu       = each.value.cpu
  disk_size = each.value.disk
  memory    = each.value.memory
  name      = "${var.tenant_name}_${each.key}"
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
  policy_name  = each.value.name != "" ? each.value.name : "${var.tenant_name}_vm"
  dns_servers  = var.dns_servers_v4
  domain_name  = var.domain_name
  ntp_servers  = var.ntp_servers != [] ? var.ntp_servers : var.dns_servers_v4
  pod_cidr     = each.value.cidr_pod
  service_cidr = each.value.cidr_service
  timezone     = var.timezone
  tags         = each.value.tags != null ? each.value.tags : var.tags
}


#__________________________________________________________
#
# Intersight Kubernetes Service Cluster Profiles
#__________________________________________________________

#______________________________________________
#
# Create the IKS Cluster Profile
#______________________________________________

module "iks_cluster" {
  depends_on = [
    module.ip_pools,
    module.k8s_addons,
    module.k8s_runtime_policies,
    module.k8s_trusted_registries,
    module.k8s_version_policies,
    module.k8s_vm_infra_policies,
    module.k8s_vm_instance,
    module.k8s_vm_network_policy
  ]
  source                   = "terraform-cisco-modules/imm/intersight//modules/k8s_cluster"
  for_each                 = local.iks_cluster
  action                   = each.value.action_cluster
  container_runtime_config = length(each.value.runtime_moid) > 0 ? module.k8s_runtime_policies["${each.value.runtime_moid}"].runtime_policy_moid : []
  ip_pool_moid             = module.ip_pools["${each.value.ip_pool_moid}"].moid
  load_balancer            = each.value.load_balancers
  name                     = "${var.tenant_name}_${each.key}"
  net_config_moid          = module.k8s_vm_network_policy["${each.value.vm_network_moid}"].network_policy_moid
  org_moid                 = local.org_moid
  ssh_key                  = each.value.ssh_key == "ssh_key_1" ? var.ssh_key_1 : each.value.ssh_key == "ssh_key_2" ? var.ssh_key_2 : each.value.ssh_key == "ssh_key_3" ? var.ssh_key_3 : each.value.ssh_key == "ssh_key_4" ? var.ssh_key_4 : var.ssh_key_5
  ssh_user                 = each.value.ssh_user
  sys_config_moid          = module.k8s_vm_network_policy["${each.value.vm_network_moid}"].sys_config_policy_moid
  tags                     = each.value.tags != [] ? each.value.tags : var.tags
  trusted_registry_moid    = each.value.registry_moid != "" ? module.k8s_trusted_registries["${each.value.registry_moid}"].trusted_registry_moid : null
  wait_for_completion      = each.value.wait_for_complete
}

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

# module "iks_addon_profile" {
#   source = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
#   depends_on = [
#     module.k8s_addons,
#     module.iks_cluster
#   ]
#   for_each     = local.iks_cluster
#   profile_name = "${var.tenant_name}_${each.key}_addons"
#
#   addons       = [
#     "${var.tenant_name}_ccp-monitor",
#     "${var.tenant_name}_kubernetes-dashboard"
#   ]
#   cluster_moid = module.iks_cluster["${each.key}"].moid
#   org_name     = var.organization
#   tags         = var.tags
# }

# module "iks_addon_profile" {
#   depends_on = [
#     module.iks_cluster
#   ]
#   source   = "terraform-cisco-modules/imm/intersight//modules/k8s_cluster_addons"
#   for_each = local.iks_cluster
#   addons = [
#     for a in each.value.addons :
#     {
#       moid = module.k8s_addons["${a}"].moid
#       name = module.k8s_addons["${a}"].name
#     }
#   ]
#   cluster_moid = module.iks_cluster["${each.key}"].moid
#   name         = "${var.tenant_name}_${each.key}_addons"
#   org_moid     = local.org_moid
#   tags         = each.value.tags != [] ? each.value.tags : var.tags
# }


#______________________________________________
#
# Create the Control Plane Profile
#______________________________________________

module "control_plane_profile" {
  depends_on = [
    module.iks_cluster,
  ]
  source       = "terraform-cisco-modules/imm/intersight//modules/k8s_node_profile"
  for_each     = local.iks_cluster
  action       = each.value.action_control_plane
  description  = "${var.tenant_name}_${each.key} Control Plane Node Profile"
  cluster_moid = module.iks_cluster["${each.key}"].moid
  desired_size = each.value.control_plane_desired_size
  ip_pool_moid = module.ip_pools["${each.value.ip_pool_moid}"].moid
  max_size     = each.value.control_plane_max_size
  name         = "${var.tenant_name}_${each.key}_control_plane"
  node_type    = each.value.worker_desired_size == "0" ? "ControlPlaneWorker" : "ControlPlane"
  tags         = each.value.tags != [] ? each.value.tags : var.tags
  version_moid = module.k8s_version_policies["${each.value.version_moid}"].version_policy_moid
}

module "control_plane_instance_type" {
  depends_on = [
    module.control_plane_profile
  ]
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  for_each                 = local.iks_cluster
  infra_config_policy_moid = module.k8s_vm_infra_policies["${each.value.k8s_vm_infra_moid}"].moid
  instance_type_moid       = module.k8s_vm_instance["${each.value.control_plane_intance_moid}"].worker_profile_moid
  name                     = "${var.tenant_name}_${each.key}_control_plane"
  node_group_moid          = module.control_plane_profile["${each.key}"].moid
  tags                     = each.value.tags != [] ? each.value.tags : var.tags
}


#______________________________________________
#
# Create the Worker Profile
#______________________________________________

module "worker_profile" {
  depends_on = [
    module.iks_cluster
  ]
  source       = "terraform-cisco-modules/imm/intersight//modules/k8s_node_profile"
  for_each     = local.iks_cluster
  action       = each.value.action_worker
  description  = "${var.tenant_name}_${each.key} Worker Node Profile"
  cluster_moid = module.iks_cluster["${each.key}"].moid
  desired_size = each.value.worker_desired_size
  ip_pool_moid = module.ip_pools["${each.value.ip_pool_moid}"].moid
  max_size     = each.value.worker_max_size
  name         = "${var.tenant_name}_${each.key}_worker"
  node_type    = "Worker"
  tags         = each.value.tags != [] ? each.value.tags : var.tags
  version_moid = module.k8s_version_policies["${each.value.version_moid}"].version_policy_moid
}

module "worker_instance_type" {
  # skip this module if the worker_desired_size is 0
  depends_on = [
    module.worker_profile
  ]
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  for_each                 = local.iks_cluster
  infra_config_policy_moid = module.k8s_vm_infra_policies["${each.value.k8s_vm_infra_moid}"].moid
  instance_type_moid       = module.k8s_vm_instance["${each.value.worker_intance_moid}"].worker_profile_moid
  name                     = "${var.tenant_name}_${each.key}_worker"
  node_group_moid          = module.worker_profile["${each.key}"].moid
  tags                     = each.value.tags != [] ? each.value.tags : var.tags
}
