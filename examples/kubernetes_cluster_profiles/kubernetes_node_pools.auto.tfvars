#__________________________________________________________
#
# Kubernetes Node Pools Variables
#__________________________________________________________

kubernetes_node_pools = {
  "wakanda_k8s_cl02_ctrl_plane" = {
    action                  = "No-op"
    description             = "Wakanda Kubernetes Cluster02 Control Plane"
    desired_size            = 1
    ip_pool_moid            = "Wakanda_pool_v4"
    kubernetes_cluster_moid = "wakanda_k8s_cl02"
    kubernetes_labels = [
      {
        key   = "Node Pool"
        value = "Control Plane"
      }
    ]
    kubernetes_version_moid = "Wakanda_v1_19_5"
    max_size                = 3
    min_size                = 1
    node_type               = "ControlPlane"
    organization            = "Wakanda"
    vm_infra_config_moid    = "Wakanda_vm_infra"
    vm_instance_type_moid   = "Wakanda_small"
  }
  "wakanda_k8s_cl02_worker01" = {
    action                  = "No-op"
    description             = "Wakanda Kubernetes Cluster01 Worker Pool 1"
    desired_size            = 1
    ip_pool_moid            = "Wakanda_pool_v4"
    kubernetes_cluster_moid = "wakanda_k8s_cl02"
    kubernetes_labels = [
      {
        key   = "Node Pool"
        value = "Worker Pool 1"
      }
    ]
    kubernetes_version_moid = "Wakanda_v1_19_5"
    max_size                = 3
    min_size                = 1
    node_type               = "Worker"
    organization            = "Wakanda"
    vm_infra_config_moid    = "Wakanda_vm_infra"
    vm_instance_type_moid   = "Wakanda_small"
  }
}
