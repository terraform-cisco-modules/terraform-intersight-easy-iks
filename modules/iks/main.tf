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
  description      = each.value.description != "" ? each.value.description : "${var.tenant_name} IP Pool."
  dns_servers_v4   = each.value.dns_servers_v4
  name             = each.value.name != "" ? each.value.name : "${var.tenant_name}_ip_pool"
  org_moid         = local.org_moid
  tags             = each.value.tags != [] ? each.value.tags : local.tags
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

module "k8s_addon_policies" {
  source           = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_addons"
  for_each         = local.k8s_addon_policies
  addon            = each.key
  description      = each.value.description != "" ? each.value.description : "${var.tenant_name} Kubernetes Add-ons Policy for ${each.key}."
  install_strategy = each.value.install_strategy
  name             = each.value.name != "" ? each.value.name : "${var.tenant_name}_${each.key}"
  org_moid         = local.org_moid
  release_name     = each.value.release_name
  upgrade_strategy = each.value.upgrade_strategy
  tags             = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Intersight Kubernetes Network CIDR Policy
#______________________________________________

module "k8s_network_cidr" {
  source       = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_network_cidr"
  for_each     = local.k8s_network_cidr
  cidr_pod     = each.value.cidr_pod
  cidr_service = each.value.cidr_service
  cni_type     = each.value.cni_type
  description  = each.value.description != "" ? each.value.description : "${var.tenant_name} Kubernetes Network CIDR Policy."
  org_moid     = local.org_moid
  name         = each.value.name != "" ? each.value.name : "${var.tenant_name}_network_cidr"
  tags         = each.value.tags != null ? each.value.tags : local.tags
}


#______________________________________________
#
# Intersight Kubernetes Node OS Config Policy
#______________________________________________

module "k8s_nodeos_config" {
  source         = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_nodeos_config"
  for_each       = local.k8s_nodeos_config
  description    = each.value.description != "" ? each.value.description : "${var.tenant_name} Kubernetes Network CIDR Policy."
  dns_servers_v4 = each.value.dns_servers_v4
  domain_name    = each.value.domain_name
  name           = each.value.name != "" ? each.value.name : "${var.tenant_name}_nodeos_config"
  ntp_servers    = each.value.ntp_servers != [] ? each.value.ntp_servers : each.value.dns_servers_v4
  org_moid       = local.org_moid
  tags           = each.value.tags != null ? each.value.tags : local.tags
  timezone       = each.value.timezone
}


#______________________________________________
#
# Kubernetes Runtime Policy Module
#______________________________________________

module "k8s_runtime_policies" {
  source               = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_runtime"
  for_each             = var.k8s_runtime_create == true ? local.k8s_runtime : {}
  description          = each.value.description != "" ? each.value.description : "${var.tenant_name} Runtime Policy."
  docker_bridge_cidr   = each.value.docker_bridge_cidr
  docker_no_proxy      = each.value.docker_no_proxy
  org_moid             = local.org_moid
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
  tags                 = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Kubernetes Trusted Registry Policy Module
#______________________________________________

module "k8s_trusted_registries" {
  source              = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_trusted_registries"
  for_each            = var.k8s_trusted_create == true ? local.k8s_trusted_registry : {}
  description         = each.value.description != "" ? each.value.description : "${var.tenant_name} Trusted Registry Policy."
  name                = each.value.name != "" ? each.value.name : "${var.tenant_name}_registry"
  org_moid            = local.org_moid
  root_ca_registries  = each.value.root_ca != [] ? each.value.root_ca : []
  unsigned_registries = each.value.unsigned != [] ? each.value.unsigned : []
  tags                = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Kubernetes Version Policy Module
#______________________________________________

module "k8s_version_policies" {
  source      = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_version"
  for_each    = local.k8s_version
  description = each.value.description != "" ? each.value.description : "${var.tenant_name} Version ${each.value.version} Policy."
  name        = each.value.name != "" ? "${each.value.name}_v${each.value.version}" : "${var.tenant_name}_v${each.value.version}"
  org_moid    = local.org_moid
  k8s_version = each.value.version
  tags        = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Kubernetes Virtual Machine Infra Config
#______________________________________________

module "k8s_vm_infra_config" {
  source                = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_vm_infra"
  for_each              = local.k8s_vm_infra_config
  description           = each.value.description != "" ? each.value.description : "${var.tenant_name} Virtual Machine Infra Config Policy."
  name                  = each.value.name != "" ? each.value.name : "${var.tenant_name}_vm_infra"
  org_moid              = local.org_moid
  tags                  = each.value.tags != null ? each.value.tags : local.tags
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

module "k8s_vm_instance_type" {
  source      = "terraform-cisco-modules/imm/intersight//modules/policies_k8s_vm_instance_type"
  for_each    = local.k8s_vm_instance_type
  cpu         = each.value.cpu
  description = each.value.description != "" ? each.value.description : "${var.tenant_name} ${each.key} VM Instance Policy."
  disk_size   = each.value.disk
  memory      = each.value.memory
  name        = "${var.tenant_name}_${each.key}"
  org_moid    = local.org_moid
  tags        = each.value.tags != [] ? each.value.tags : local.tags
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
    module.k8s_addon_policies,
    module.k8s_network_cidr,
    module.k8s_nodeos_config,
    module.k8s_runtime_policies,
    module.k8s_trusted_registries,
    module.k8s_version_policies,
    module.k8s_vm_infra_config,
    module.k8s_vm_instance_type,
  ]
  source                   = "terraform-cisco-modules/imm/intersight//modules/k8s_cluster"
  for_each                 = local.iks_cluster
  action                   = each.value.action_cluster
  container_runtime_config = each.value.k8s_runtime_moid != "" ? module.k8s_runtime_policies["${each.value.k8s_runtime_moid}"].moid : []
  description              = each.value.description != "" ? each.value.description : "${var.tenant_name} ${each.key} IKS Cluster."
  ip_pool_moid             = module.ip_pools["${each.value.ip_pool_moid}"].moid
  load_balancer            = each.value.load_balancers
  name                     = "${var.tenant_name}_${each.key}"
  net_config_moid          = module.k8s_network_cidr["${each.value.k8s_network_cidr_moid}"].moid
  org_moid                 = local.org_moid
  ssh_key                  = each.value.ssh_key == "ssh_key_1" ? var.ssh_key_1 : each.value.ssh_key == "ssh_key_2" ? var.ssh_key_2 : each.value.ssh_key == "ssh_key_3" ? var.ssh_key_3 : each.value.ssh_key == "ssh_key_4" ? var.ssh_key_4 : var.ssh_key_5
  ssh_user                 = each.value.ssh_user
  sys_config_moid          = module.k8s_nodeos_config["${each.value.k8s_nodeos_config_moid}"].moid
  tags                     = each.value.tags != [] ? each.value.tags : local.tags
  trusted_registries       = each.value.k8s_registry_moid != "" ? module.k8s_trusted_registries["${each.value.k8s_registry_moid}"].moid : null
  wait_for_completion      = each.value.wait_for_complete
}

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

# module "iks_addon_profile" {
#   depends_on = [
#     module.iks_cluster
#   ]
#   source   = "terraform-cisco-modules/imm/intersight//modules/k8s_cluster_addons"
#   for_each = local.iks_cluster
#   addons = [
#     for a in each.value.k8s_addon_policy_moid :
#     {
#       moid = module.k8s_addons["${a}"].moid
#       name = module.k8s_addons["${a}"].name
#     }
#   ]
#   cluster_moid = module.iks_cluster["${each.key}"].moid
#   name         = "${var.tenant_name}_${each.key}_addons"
#   org_moid     = local.org_moid
#   tags         = each.value.tags != [] ? each.value.tags : local.tags
# }


#______________________________________________
#
# Create the Control Plane Profile
#______________________________________________

module "control_plane_node_group" {
  depends_on = [
    module.iks_cluster,
  ]
  source       = "terraform-cisco-modules/imm/intersight//modules/k8s_node_group_profile"
  for_each     = local.iks_cluster
  action       = each.value.action_control_plane
  description  = each.value.description != "" ? each.value.description : "${var.tenant_name}_${each.key} Control Plane Node Profile"
  cluster_moid = module.iks_cluster["${each.key}"].moid
  desired_size = each.value.control_plane_desired_size
  ip_pool_moid = module.ip_pools["${each.value.ip_pool_moid}"].moid
  labels       = each.value.control_plane_k8s_labels
  max_size     = each.value.control_plane_max_size
  name         = "${var.tenant_name}_${each.key}_control_plane"
  node_type    = each.value.worker_desired_size == "0" ? "ControlPlaneWorker" : "ControlPlane"
  tags         = each.value.tags != [] ? each.value.tags : local.tags
  version_moid = module.k8s_version_policies["${each.value.k8s_version_moid}"].moid
}

module "control_plane_vm_infra_provider" {
  depends_on = [
    module.control_plane_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider"
  for_each                  = local.iks_cluster
  description               = each.value.description != "" ? each.value.description : "${var.tenant_name}_${each.key} Control Plane Virtual machine Infrastructure Provider."
  k8s_node_group_moid       = module.control_plane_node_group["${each.key}"].moid
  k8s_vm_infra_config_moid  = module.k8s_vm_infra_config["${each.value.k8s_vm_infra_moid}"].moid
  k8s_vm_instance_type_moid = module.k8s_vm_instance_type["${each.value.k8s_vm_instance_type_ctrl_plane}"].moid
  name                      = "${var.tenant_name}_${each.key}_control_plane"
  tags                      = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Create the Worker Profile
#______________________________________________

module "worker_node_group" {
  depends_on = [
    module.iks_cluster
  ]
  source       = "terraform-cisco-modules/imm/intersight//modules/k8s_node_group_profile"
  for_each     = local.iks_cluster
  action       = each.value.action_worker
  description  = each.value.description != "" ? each.value.description : "${var.tenant_name}_${each.key} Worker Node Profile"
  cluster_moid = module.iks_cluster["${each.key}"].moid
  desired_size = each.value.worker_desired_size
  ip_pool_moid = module.ip_pools["${each.value.ip_pool_moid}"].moid
  labels       = each.value.worker_k8s_labels
  max_size     = each.value.worker_max_size
  name         = "${var.tenant_name}_${each.key}_worker"
  node_type    = "Worker"
  tags         = each.value.tags != [] ? each.value.tags : local.tags
  version_moid = module.k8s_version_policies["${each.value.k8s_version_moid}"].moid
}

module "worker_vm_infra_provider" {
  depends_on = [
    module.worker_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider"
  for_each                  = local.iks_cluster
  description               = each.value.description != "" ? each.value.description : "${var.tenant_name}_${each.key} Worker Virtual machine Infrastructure Provider."
  k8s_node_group_moid       = module.worker_node_group["${each.key}"].moid
  k8s_vm_infra_config_moid  = module.k8s_vm_infra_config["${each.value.k8s_vm_infra_moid}"].moid
  k8s_vm_instance_type_moid = module.k8s_vm_instance_type["${each.value.k8s_vm_instance_type_worker}"].moid
  name                      = "${var.tenant_name}_${each.key}_worker"
  tags                      = each.value.tags != [] ? each.value.tags : local.tags
}
