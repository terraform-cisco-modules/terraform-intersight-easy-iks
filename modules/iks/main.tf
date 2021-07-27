#__________________________________________________________
#
# Get outputs from the Organization Policies Workspace
#__________________________________________________________

# data "terraform_remote_state" "organization" {
#   backend = "local"
#   config = {
#     path = "../organization/terraform.tfstate"
#   }
# }

data "terraform_remote_state" "organization" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = local.organization
    }
  }
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
  source                   = "terraform-cisco-modules/imm/intersight//modules/k8s_cluster"
  action                   = local.cluster_vars.action_cluster
  container_runtime_config = local.cluster_vars.k8s_runtime_moid != "" ? local.k8s_runtime_policies["${local.cluster_vars.k8s_runtime_moid}"] : ""
  description              = local.cluster_vars.description != "" ? local.cluster_vars.description : "${local.organization}_${var.iks_cluster} IKS Cluster."
  ip_pool_moid             = local.ip_pools[local.cluster_vars.ip_pool_moid]
  load_balancer            = local.cluster_vars.load_balancers
  name                     = "${local.organization}_${var.iks_cluster}"
  net_config_moid          = local.k8s_network_cidr[local.cluster_vars.k8s_network_cidr_moid]
  org_moid                 = local.org_moid
  ssh_key                  = local.cluster_vars.ssh_key == "ssh_key_1" ? var.ssh_key_1 : local.cluster_vars.ssh_key == "ssh_key_2" ? var.ssh_key_2 : local.cluster_vars.ssh_key == "ssh_key_3" ? var.ssh_key_3 : local.cluster_vars.ssh_key == "ssh_key_4" ? var.ssh_key_4 : var.ssh_key_5
  ssh_user                 = local.cluster_vars.ssh_user
  sys_config_moid          = local.k8s_nodeos_config[local.cluster_vars.k8s_nodeos_config_moid]
  tags                     = local.cluster_vars.tags != [] ? local.cluster_vars.tags : local.tags
  trusted_registries       = local.cluster_vars.k8s_registry_moid != "" ? local.k8s_trusted_registries[local.cluster_vars.k8s_registry_moid] : ""
  wait_for_completion      = local.cluster_vars.wait_for_complete
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
#   addons = [
#     for a in local.cluster_vars.k8s_addon_policy_moid :
#     {
#       moid = module.k8s_addon_policies["${a}"].moid
#       name = module.k8s_addon_policies["${a}"].name
#     }
#   ]
#   cluster_moid = module.iks_cluster.moid
#   name         = "${local.organization}_${var.iks_cluster}_addons"
#   org_moid     = local.org_moid
#   tags         = local.cluster_vars.tags != [] ? local.cluster_vars.tags : local.tags
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
  action       = local.cluster_vars.action_control_plane
  description  = local.cluster_vars.description != "" ? local.cluster_vars.description : "${local.organization}_${var.iks_cluster} Control Plane Node Profile"
  cluster_moid = module.iks_cluster.moid
  desired_size = local.cluster_vars.control_plane_desired_size
  ip_pool_moid = local.ip_pools[local.cluster_vars.ip_pool_moid]
  labels       = local.cluster_vars.control_plane_k8s_labels
  max_size     = local.cluster_vars.control_plane_max_size
  name         = "${local.organization}_${var.iks_cluster}_control_plane"
  node_type    = local.cluster_vars.worker_desired_size == "0" ? "ControlPlaneWorker" : "ControlPlane"
  tags         = local.cluster_vars.tags != [] ? local.cluster_vars.tags : local.tags
  version_moid = local.k8s_version_policies[local.cluster_vars.k8s_version_moid]
}

module "control_plane_vm_infra_provider" {
  depends_on = [
    module.control_plane_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider"
  description               = local.cluster_vars.description != "" ? local.cluster_vars.description : "${local.organization}_${var.iks_cluster} Control Plane Virtual machine Infrastructure Provider."
  k8s_node_group_moid       = module.control_plane_node_group.moid
  k8s_vm_infra_config_moid  = local.k8s_vm_infra_config[local.cluster_vars.k8s_vm_infra_moid]
  k8s_vm_instance_type_moid = local.k8s_vm_instance_type[local.cluster_vars.k8s_vm_instance_type_ctrl_plane]
  name                      = "${local.organization}_${var.iks_cluster}_control_plane"
  tags                      = local.cluster_vars.tags != [] ? local.cluster_vars.tags : local.tags
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
  action       = local.cluster_vars.action_worker
  description  = local.cluster_vars.description != "" ? local.cluster_vars.description : "${local.organization}_${var.iks_cluster} Worker Node Profile"
  cluster_moid = module.iks_cluster.moid
  desired_size = local.cluster_vars.worker_desired_size
  ip_pool_moid = local.ip_pools[local.cluster_vars.ip_pool_moid]
  labels       = local.cluster_vars.worker_k8s_labels
  max_size     = local.cluster_vars.worker_max_size
  name         = "${local.organization}_${var.iks_cluster}_worker"
  node_type    = "Worker"
  tags         = local.cluster_vars.tags != [] ? local.cluster_vars.tags : local.tags
  version_moid = local.k8s_version_policies[local.cluster_vars.k8s_version_moid]
}

module "worker_vm_infra_provider" {
  depends_on = [
    module.worker_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider"
  description               = local.cluster_vars.description != "" ? local.cluster_vars.description : "${local.organization}_${var.iks_cluster} Worker Virtual machine Infrastructure Provider."
  k8s_node_group_moid       = module.worker_node_group.moid
  k8s_vm_infra_config_moid  = local.k8s_vm_infra_config[local.cluster_vars.k8s_vm_infra_moid]
  k8s_vm_instance_type_moid = local.k8s_vm_instance_type[local.cluster_vars.k8s_vm_instance_type_worker]
  name                      = "${local.organization}_${var.iks_cluster}_worker"
  tags                      = local.cluster_vars.tags != [] ? local.cluster_vars.tags : local.tags
}
