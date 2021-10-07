#__________________________________________________________
#
# Intersight Kubernetes Service Cluster Profiles
#__________________________________________________________

#______________________________________________
#
# Create the IKS Cluster Profile
#______________________________________________

module "kubernetes_cluster_profiles" {
  source   = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_profiles"
  for_each = local.kubernetes_cluster_profiles
  action   = each.value.action_cluster
  container_runtime_config = length(
    regexall("r[a-zA-Z0-9]+", coalesce(each.value.container_runtime_policies, "####"))
  ) > 0 ? local.container_runtime_policies[each.value.container_runtime_moid] : ""
  description     = each.value.description != "" ? each.value.description : "${each.key} IKS Cluster."
  ip_pool_moid    = local.ip_pools[each.value.ip_pool_moid]
  load_balancer   = each.value.load_balancers
  name            = each.key
  net_config_moid = local.network_cidr_policies[each.value.network_cidr_moid]
  org_moid        = local.org_moids[each.value.organization].moid
  ssh_key = length(
    regexall("ssh_key_1", each.value.ssh_key)) > 0 ? var.ssh_key_1 : length(
    regexall("ssh_key_2", each.value.ssh_key)) > 0 ? var.ssh_key_2 : length(
    regexall("ssh_key_3", each.value.ssh_key)) > 0 ? var.ssh_key_3 : length(
    regexall("ssh_key_4", each.value.ssh_key)) > 0 ? var.ssh_key_4 : length(
    regexall("ssh_key_5", each.value.ssh_key)
  ) > 0 ? var.ssh_key_5 : ""
  ssh_user        = each.value.ssh_user
  sys_config_moid = local.nodeos_config_policies[each.value.nodeos_config_moid]
  tags            = each.value.tags != [] ? each.value.tags : local.tags
  trusted_registries = length(
    regexall("r[a-zA-Z0-9]+", coalesce(each.value.trusted_certificate_authorities, "####"))
  ) > 0 ? local.trusted_certificate_authorities[each.value.trusted_certificate_authority_moid] : ""
  wait_for_completion = each.value.wait_for_complete
}

#_____________________________________________________
#
# Attach the Add-Ons Policy to the Kubernetes Cluster
#_____________________________________________________

module "kubernetes_cluster_addons" {
  depends_on = [
    module.kubernetes_cluster_profiles
  ]
  source   = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_addons"
  for_each = local.kubernetes_cluster_profiles
  addons = [
    for a in each.value.k8s_addon_policy_moid :
    {
      moid = local.k8s_addon_policies["${a}"].moid
      name = local.k8s_addon_policies["${a}"].name
    }
  ]
  kubernetes_cluster_profile_moid = module.kubernetes_cluster_profiles[each.key].cluster_moid
  name                            = "${each.key}_addons"
  org_moid                        = local.org_moids[each.value.organization].moid
  tags                            = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Create the Control Plane Profile
#______________________________________________

module "control_plane_node_group" {
  depends_on = [
    module.kubernetes_cluster_profiles,
  ]
  source                          = "terraform-cisco-modules/imm/intersight//modules/kubernetes_node_group_profiles"
  for_each                        = local.kubernetes_cluster_profiles
  action                          = each.value.action_control_plane
  description                     = each.value.description != "" ? each.value.description : "${each.key} Node Group Profile"
  desired_size                    = each.value.control_plane_desired_size
  kubernetes_cluster_profile_moid = module.kubernetes_cluster_profiles[each.key].profile_moid
  kubernetes_version_moid         = local.kubernetes_version_policies[each.value.kubernetes_version_moid]
  ip_pool_moid                    = local.ip_pools[each.value.ip_pool_moid]
  labels                          = each.value.control_plane_k8s_labels
  max_size                        = each.value.control_plane_max_size
  name                            = "${each.key}_control_plane"
  node_type                       = each.value.worker_desired_size == "0" ? "ControlPlaneWorker" : "ControlPlane"
  tags                            = each.value.tags != [] ? each.value.tags : local.tags
}

module "control_plane_node_vm_infra" {
  depends_on = [
    module.control_plane_node_group
  ]
  source                    = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_node_vm_infra"
  for_each                  = local.kubernetes_cluster_profiles
  description               = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Virtual machine Infrastructure Provider"
  k8s_node_group_moid       = module.control_plane_node_group[each.key].moid
  k8s_vm_infra_config_moid  = local.virtual_machine_infra_config[each.value.virtual_machine_infra_config_moid]
  k8s_vm_instance_type_moid = local.k8s_vm_instance_type[each.value.k8s_vm_instance_type_ctrl_plane]
  name                      = "${each.key}_control_plane"
  tags                      = each.value.tags != [] ? each.value.tags : local.tags
}


#______________________________________________
#
# Create the Worker Profile
#______________________________________________

module "worker_node_group" {
  depends_on = [
    module.kubernetes_cluster_profiles
  ]
  source                          = "terraform-cisco-modules/imm/intersight//modules/kubernetes_node_group_profiles"
  for_each                        = local.kubernetes_cluster_profiles
  action                          = each.value.action_worker
  description                     = each.value.description != "" ? each.value.description : "${each.key} Worker Node Profile"
  kubernetes_cluster_profile_moid = module.kubernetes_cluster_profiles[each.key].profile_moid
  kubernetes_version_moid         = local.kubernetes_version_policies[each.value.kubernetes_version_moid]
  desired_size                    = each.value.worker_desired_size
  ip_pool_moid                    = local.ip_pools[each.value.ip_pool_moid]
  labels                          = each.value.worker_k8s_labels
  max_size                        = each.value.worker_max_size
  name                            = "${each.key}_worker"
  node_type                       = "Worker"
  tags                            = each.value.tags != [] ? each.value.tags : local.tags
}

module "worker_node_vm_infra" {
  depends_on = [
    module.worker_node_group
  ]
  source                     = "terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_node_vm_infra"
  for_each                   = local.kubernetes_cluster_profiles
  description                = each.value.description != "" ? each.value.description : "${each.key} Worker Virtual machine Infrastructure Provider."
  kubernetes_node_group_moid = module.worker_node_group[each.key].moid
  name                       = "${each.key}_worker"
  tags                       = each.value.tags != [] ? each.value.tags : local.tags
  vm_infra_config_moid       = local.virtual_machine_infra_config[each.value.control_plane_vm_instance_type_moid]
  vm_instance_type_moid      = local.virtual_machine_instance_type[each.value.worker_vm_instance_type_moid]
}
