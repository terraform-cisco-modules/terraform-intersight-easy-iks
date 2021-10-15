#__________________________________________________________
#
# Kubernetes Cluster Profile Variables
#__________________________________________________________

kubernetes_cluster_profiles = {
  "#Cluster#_k8s_cl02" = {
    action                             = "Deploy" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons_policy_moid                 = ["ccp-monitor", "kubernetes-dashboard"]
    container_runtime_moid             = ""
    ip_pool_moid                       = "#Cluster#_pool_v4"
    network_cidr_moid                  = "#Cluster#_network_cidr"
    nodeos_configuration_moid          = "#Cluster#_nodeos_config"
    load_balancer_count                = 3
    organization                       = "default"
    ssh_public_key                     = "ssh_public_key_1"
    ssh_user                           = "iksadmin"
    tags                               = []
    trusted_certificate_authority_moid = "#Cluster#_registry"
    wait_for_complete                  = false
  }
}
