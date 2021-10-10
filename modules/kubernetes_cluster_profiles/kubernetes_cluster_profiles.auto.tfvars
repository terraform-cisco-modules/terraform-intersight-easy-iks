#__________________________________________________________
#
# Kubernetes Cluster Profile Variables
#__________________________________________________________

kubernetes_cluster_profiles = {
  "wakanda_k8s_cl01" = {
    action                      = "Deploy" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons_policy_moid                  = ["ccp-monitor", "kubernetes-dashboard"]
    container_runtime_moid              = ""
    ip_pool_moid = "Wakanda_pool_v4"
    network_cidr_moid                   = "Wakanda_network_cidr"
    nodeos_configuration_moid           = "Wakanda_nodeos_config"
    load_balancer_count                 = 3
    organization                        = "Wakanda"
    ssh_public_key                      = "ssh_public_key_1"
    ssh_user                            = "iksadmin"
    tags                                = []
    trusted_certificate_authority_moid  = "Wakanda_registry"
    wait_for_complete                   = false
  }
}
