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
  for_each                 = local.iks_cluster
  action                   = each.value.action_cluster
  container_runtime_config = each.value.k8s_runtime_moid != "" ? local.k8s_runtime_policies["${each.value.k8s_runtime_moid}"] : ""
  description              = each.value.description != "" ? each.value.description : "${var.organization} ${each.key} IKS Cluster."
  ip_pool_moid             = local.ip_pools[each.value.ip_pool_moid]
  load_balancer            = each.value.load_balancers
  name                     = "${var.organization}_${each.key}"
  net_config_moid          = local.k8s_network_cidr[each.value.k8s_network_cidr_moid]
  org_moid                 = local.org_moid
  ssh_key                  = each.value.ssh_key == "ssh_key_1" ? var.ssh_key_1 : each.value.ssh_key == "ssh_key_2" ? var.ssh_key_2 : each.value.ssh_key == "ssh_key_3" ? var.ssh_key_3 : each.value.ssh_key == "ssh_key_4" ? var.ssh_key_4 : var.ssh_key_5
  ssh_user                 = each.value.ssh_user
  sys_config_moid          = local.k8s_nodeos_config[each.value.k8s_nodeos_config_moid]
  tags                     = each.value.tags != [] ? each.value.tags : local.tags
  trusted_registries       = each.value.k8s_registry_moid != "" ? local.k8s_trusted_registries[each.value.k8s_registry_moid] : ""
  wait_for_completion      = each.value.wait_for_complete
}

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

module "iks_addon_profile" {
  depends_on = [
    module.iks_cluster
  ]
  source   = "terraform-cisco-modules/imm/intersight//modules/k8s_cluster_addons"
  for_each = local.iks_cluster
  addons = [
    for a in each.value.k8s_addon_policy_moid :
    {
      moid = module.k8s_addon_policies["${a}"].moid
      name = module.k8s_addon_policies["${a}"].name
    }
  ]
  cluster_moid = module.iks_cluster["${each.key}"].moid
  name         = "${var.organization}_${each.key}_addons"
  org_moid     = local.org_moid
  tags         = each.value.tags != [] ? each.value.tags : local.tags
}


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
  description  = each.value.description != "" ? each.value.description : "${var.organization}_${each.key} Control Plane Node Profile"
  cluster_moid = module.iks_cluster[each.key].moid
  desired_size = each.value.control_plane_desired_size
  ip_pool_moid = local.ip_pools[each.value.ip_pool_moid]
  labels       = each.value.control_plane_k8s_labels
  max_size     = each.value.control_plane_max_size
  name         = "${var.organization}_${each.key}_control_plane"
  node_type    = each.value.worker_desired_size == "0" ? "ControlPlaneWorker" : "ControlPlane"
  tags         = each.value.tags != [] ? each.value.tags : local.tags
  version_moid = local.k8s_version_policies[each.value.k8s_version_moid]
}

module "control_plane_vm_infra_provider" {
  depends_on = [
    module.control_plane_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider"
  for_each                  = local.iks_cluster
  description               = each.value.description != "" ? each.value.description : "${var.organization}_${each.key} Control Plane Virtual machine Infrastructure Provider."
  k8s_node_group_moid       = module.control_plane_node_group[each.key].moid
  k8s_vm_infra_config_moid  = local.k8s_vm_infra_config[each.value.k8s_vm_infra_moid]
  k8s_vm_instance_type_moid = local.k8s_vm_instance_type[each.value.k8s_vm_instance_type_ctrl_plane]
  name                      = "${var.organization}_${each.key}_control_plane"
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
  description  = each.value.description != "" ? each.value.description : "${var.organization}_${each.key} Worker Node Profile"
  cluster_moid = module.iks_cluster[each.key].moid
  desired_size = each.value.worker_desired_size
  ip_pool_moid = local.ip_pools[each.value.ip_pool_moid]
  labels       = each.value.worker_k8s_labels
  max_size     = each.value.worker_max_size
  name         = "${var.organization}_${each.key}_worker"
  node_type    = "Worker"
  tags         = each.value.tags != [] ? each.value.tags : local.tags
  version_moid = local.k8s_version_policies[each.value.k8s_version_moid]
}

module "worker_vm_infra_provider" {
  depends_on = [
    module.worker_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider"
  for_each                  = local.iks_cluster
  description               = each.value.description != "" ? each.value.description : "${var.organization}_${each.key} Worker Virtual machine Infrastructure Provider."
  k8s_node_group_moid       = module.worker_node_group[each.key].moid
  k8s_vm_infra_config_moid  = local.k8s_vm_infra_config[each.value.k8s_vm_infra_moid]
  k8s_vm_instance_type_moid = local.k8s_vm_instance_type[each.value.k8s_vm_instance_type_worker]
  name                      = "${var.organization}_${each.key}_worker"
  tags                      = each.value.tags != [] ? each.value.tags : local.tags
}
