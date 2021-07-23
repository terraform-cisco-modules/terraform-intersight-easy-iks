#__________________________________________________________
#
# Get Outputs from the Global Variables Workspace
#__________________________________________________________

data "terraform_remote_state" "tenant" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_tenant
    }
  }
}


#__________________________________________________________
#
# Assign Global Attributes from tenant Workspace
#__________________________________________________________

locals {
  # Intersight Provider Variables
  endpoint = data.terraform_remote_state.tenant.outputs.endpoint
  # Intersight Organization
  organization = data.terraform_remote_state.tenant.outputs.organization
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
# Create the IKS Cluster Profile
#______________________________________________

module "iks_cluster" {
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
# Create the Control Plane Profile
#______________________________________________

module "control_plane_profile" {
  depends_on = [
    module.iks_cluster,
  ]
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  desired_size = var.control_plane_desired_size
  max_size     = var.control_plane_max_size
  name         = "${local.cluster_name}-control_plane_profile"
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

module "control_plane_instance_type" {
  depends_on = [
    module.control_plane_profile
  ]
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${local.cluster_name}-control_plane"
  instance_type_moid = trimspace(<<-EOT
  %{if var.control_plane_instance_type == "small"~}${module.k8s_instance_small.worker_profile_moid}%{endif~}
  %{if var.control_plane_instance_type == "medium"~}${module.k8s_instance_medium.worker_profile_moid}%{endif~}
  %{if var.control_plane_instance_type == "large"~}${module.k8s_instance_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid          = module.control_plane_profile.node_group_profile_moid
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
