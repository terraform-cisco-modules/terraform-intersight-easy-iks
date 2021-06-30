#__________________________________________________________
#
# Get Outputs from the Global Variables Workspace
#__________________________________________________________

data "terraform_remote_state" "global" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_global_vars
    }
  }
}


#__________________________________________________________
#
# Assign Global Attributes from global_vars Workspace
#__________________________________________________________

locals {
  # Intersight Provider Variables
  endpoint = yamldecode(data.terraform_remote_state.global.outputs.endpoint)
  # Intersight Organization
  organization = yamldecode(data.terraform_remote_state.global.outputs.organization)
  # DNS Variables
  dns_servers = data.terraform_remote_state.global.outputs.dns_servers
  domain_name = yamldecode(data.terraform_remote_state.global.outputs.domain_name)
  # Time Variables
  ntp_servers = data.terraform_remote_state.global.outputs.ntp_servers
  timezone    = yamldecode(data.terraform_remote_state.global.outputs.timezone)
  # IKS Cluster Variable
  cluster_name = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
  # IP Pool Variables
  ip_pool         = yamldecode(data.terraform_remote_state.global.outputs.ip_pool)
  ip_pool_netmask = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_netmask)
  ip_pool_gateway = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_gateway)
  ip_pool_from    = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_from)
  ip_pool_size    = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_size)
  # Kubernetes Add-ons List
  addons_list = data.terraform_remote_state.global.outputs.addons_list
  # Kubernetes Runtime Variables
  proxy_http_hostname = data.terraform_remote_state.global.outputs.proxy_http_hostname != "" ? yamldecode(
    data.terraform_remote_state.global.outputs.proxy_http_hostname
  ) : ""
  proxy_http_username = data.terraform_remote_state.global.outputs.proxy_http_username != "" ? yamldecode(
    data.terraform_remote_state.global.outputs.proxy_http_username
  ) : ""
  proxy_https_hostname = data.terraform_remote_state.global.outputs.proxy_https_hostname != "" ? yamldecode(
    data.terraform_remote_state.global.outputs.proxy_https_hostname
  ) : ""
  proxy_https_username = data.terraform_remote_state.global.outputs.proxy_https_username != "" ? yamldecode(
    data.terraform_remote_state.global.outputs.proxy_https_username
  ) : ""
  # Kubernetes Policy Names Variables
  k8s_addon_policy      = yamldecode(data.terraform_remote_state.global.outputs.k8s_addon_policy)
  k8s_runtime_policy    = yamldecode(data.terraform_remote_state.global.outputs.k8s_runtime_policy)
  k8s_trusted_registry  = yamldecode(data.terraform_remote_state.global.outputs.k8s_trusted_registry)
  k8s_version_policy    = yamldecode(data.terraform_remote_state.global.outputs.k8s_version_policy)
  k8s_vm_network_policy = yamldecode(data.terraform_remote_state.global.outputs.k8s_vm_network_policy)
  k8s_vm_infra_policy   = yamldecode(data.terraform_remote_state.global.outputs.k8s_vm_infra_policy)
  # vSphere Target Variable
  vsphere_target = yamldecode(data.terraform_remote_state.global.outputs.vsphere_target)
}


#__________________________________________________________
#
# GET the Intersight Organization moid
#__________________________________________________________

data "intersight_organization_organization" "organization_moid" {
  name = local.organization
}


#__________________________________________________________
#
# Create Kubernetes Policies
#__________________________________________________________

#______________________________________________
#
# Create the IP Pool
#______________________________________________

module "ip_pool" {
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  org_name         = local.organization
  name             = local.ip_pool
  gateway          = local.ip_pool_gateway
  netmask          = local.ip_pool_netmask
  pool_size        = local.ip_pool_size
  primary_dns      = local.dns_servers[0]
  secondary_dns    = length(local.dns_servers) > 1 ? local.dns_servers[1] : null
  starting_address = local.ip_pool_from
  tags             = var.tags
}

#_____________________________________________________
#
# Configure Add-Ons Policy for the Kubernetes Cluster
#_____________________________________________________

module "k8s_addons" {
  source   = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addons   = local.addons_list
  org_name = local.organization
  tags     = var.tags
}

#______________________________________________
#
# Create the Kubernetes VM Infra Config
#______________________________________________

module "k8s_vm_infra_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  device_name      = local.vsphere_target
  name             = local.k8s_vm_infra_policy
  org_name         = local.organization
  tags             = var.tags
  vc_password      = var.vsphere_password
  vc_cluster       = var.vsphere_cluster
  vc_datastore     = var.vsphere_datastore
  vc_portgroup     = var.vsphere_portgroup
  vc_resource_pool = var.vsphere_resource_pool
}

#______________________________________________
#
# Create the Kubernetes VM Node OS Config Policy
#______________________________________________

module "k8s_vm_network_policy" {
  source       = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  org_name     = local.organization
  policy_name  = local.k8s_vm_network_policy
  cni          = var.cni
  dns_servers  = local.dns_servers
  domain_name  = local.domain_name
  ntp_servers  = local.ntp_servers
  pod_cidr     = var.k8s_pod_cidr
  service_cidr = var.k8s_service_cidr
  timezone     = local.timezone
  tags         = var.tags
}

#______________________________________________
#
# Create the Kubernetes Version Policy
#______________________________________________

module "k8s_version_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  org_name         = local.organization
  k8s_version_name = local.k8s_version_policy
  k8s_version      = var.k8s_version
  tags             = var.tags
}

#______________________________________________
#
# Create the Kubernetes VM Instance Type Policies
# * Small
# * Medium
# * Large
#______________________________________________

module "k8s_instance_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [local.cluster_name, "small"])
  cpu       = 4
  disk_size = 40
  memory    = 16384
  tags      = var.tags
}

module "k8s_instance_medium" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [local.cluster_name, "medium"])
  cpu       = 8
  disk_size = 60
  memory    = 24576
  tags      = var.tags
}

module "k8s_instance_large" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [local.cluster_name, "large"])
  cpu       = 12
  disk_size = 80
  memory    = 32768
  tags      = var.tags
}

#______________________________________________
#
# Create the Kubernetes Runtime Policy
#______________________________________________

module "k8s_runtime_policy" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  count                = local.proxy_http_hostname != "" && local.proxy_https_hostname != "" ? 1 : 0
  docker_no_proxy      = var.docker_no_proxy
  org_name             = local.organization
  name                 = local.k8s_runtime_policy
  proxy_http_hostname  = local.proxy_http_hostname
  proxy_http_port      = var.proxy_http_port
  proxy_http_password  = var.proxy_http_password
  proxy_http_protocol  = var.proxy_http_protocol
  proxy_http_username  = local.proxy_http_username
  proxy_https_hostname = local.proxy_https_hostname
  proxy_https_password = var.proxy_https_password
  proxy_https_port     = var.proxy_https_port
  proxy_https_protocol = var.proxy_https_protocol
  proxy_https_username = local.proxy_https_username
  tags                 = var.tags
}

#______________________________________________
#
# Create the Kubernetes Trusted Registry Policy
#______________________________________________

module "k8s_trusted_registry" {
  count               = length(var.unsigned_registries) > 0 || length(var.root_ca_registries) > 0 ? 1 : 0
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  org_name            = local.organization
  policy_name         = local.k8s_trusted_registry
  root_ca_registries  = var.root_ca_registries
  unsigned_registries = var.unsigned_registries
  tags                = var.tags
}


#__________________________________________________________
#
# Create Intersight Kubernetes Cluster
#__________________________________________________________

#______________________________________________
#
# Create the IKS Cluster Profile
#______________________________________________

module "iks_cluster" {
  depends_on = [
    module.ip_pool,
    module.k8s_instance_small,
    module.k8s_instance_medium,
    module.k8s_instance_large,
    module.k8s_trusted_registry,
    module.k8s_version_policy,
    module.k8s_vm_infra_policy,
    module.k8s_vm_network_policy,
  ]
  source              = "terraform-cisco-modules/iks/intersight//modules/cluster"
  org_name            = local.organization
  action              = var.action
  wait_for_completion = false
  name                = local.cluster_name
  load_balancer       = var.load_balancers
  ssh_key             = var.ssh_key
  ssh_user            = var.ssh_user
  tags                = var.tags
  # Attach Kubernetes Policies
  ip_pool_moid                 = module.ip_pool.ip_pool_moid
  net_config_moid              = module.k8s_vm_network_policy.network_policy_moid
  sys_config_moid              = module.k8s_vm_network_policy.sys_config_policy_moid
  runtime_policy_moid          = length(module.k8s_runtime_policy) > 0 ? module.k8s_runtime_policy[0].runtime_policy_moid : null
  trusted_registry_policy_moid = length(module.k8s_trusted_registry) > 0 ? module.k8s_trusted_registry[0].trusted_registry_moid : null
}

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

module "iks_addon_profile" {
  source = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  count  = local.addons_list != null ? 1 : 0
  depends_on = [
    module.k8s_addons,
    module.iks_cluster
  ]
  # source       = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  profile_name = local.k8s_addon_policy

  addons       = keys(module.k8s_addons.addon_policy)
  cluster_moid = module.iks_cluster.k8s_cluster_moid
  org_name     = local.organization
  tags         = var.tags
}


#______________________________________________
#
# Create the Master Profile
#______________________________________________

module "master_profile" {
  depends_on = [
    module.iks_cluster,
  ]
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  desired_size = var.master_desired_size
  max_size     = var.master_max_size
  name         = "${local.cluster_name}-master_profile"
  profile_type = trimspace(<<-EOT
  %{if var.worker_desired_size == "0"~}ControlPlaneWorker
  %{else~}ControlPlane
  %{endif~}
  EOT
  )
  # Attach Kubernetes Policies
  cluster_moid = module.iks_cluster.cluster_moid
  ip_pool_moid = module.ip_pool.ip_pool_moid
  version_moid = module.k8s_version_policy.version_policy_moid
}

module "master_instance_type" {
  depends_on = [
    module.master_profile
  ]
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${local.cluster_name}-master"
  instance_type_moid = trimspace(<<-EOT
  %{if var.master_instance_type == "small"~}${module.k8s_instance_small.worker_profile_moid}%{endif~}
  %{if var.master_instance_type == "medium"~}${module.k8s_instance_medium.worker_profile_moid}%{endif~}
  %{if var.master_instance_type == "large"~}${module.k8s_instance_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid          = module.master_profile.node_group_profile_moid
  infra_config_policy_moid = module.k8s_vm_infra_policy.infra_config_moid
  tags                     = var.tags
}

#______________________________________________
#
# Create the Worker Profile
#______________________________________________

module "worker_profile" {
  count = var.worker_desired_size == "0" ? 0 : 1
  depends_on = [
    module.iks_cluster
  ]
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  desired_size = var.worker_desired_size
  max_size     = var.worker_max_size
  name         = "${local.cluster_name}-worker_profile"
  profile_type = "Worker"
  tags         = var.tags
  # Attach Kubernetes Policies
  cluster_moid = module.iks_cluster.cluster_moid
  ip_pool_moid = module.ip_pool.ip_pool_moid
  version_moid = module.k8s_version_policy.version_policy_moid
}

module "worker_instance_type" {
  # skip this module if the worker_desired_size is 0
  count = var.worker_desired_size == "0" ? 0 : 1
  depends_on = [
    module.worker_profile
  ]
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${local.cluster_name}-worker"
  instance_type_moid = trimspace(<<-EOT
  %{if var.worker_instance_type == "small"~}${module.k8s_instance_small.worker_profile_moid}%{endif~}
  %{if var.worker_instance_type == "medium"~}${module.k8s_instance_medium.worker_profile_moid}%{endif~}
  %{if var.worker_instance_type == "large"~}${module.k8s_instance_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid          = var.worker_desired_size != "0" ? module.worker_profile[0].node_group_profile_moid : null
  infra_config_policy_moid = module.k8s_vm_infra_policy.infra_config_moid
  tags                     = var.tags
}
