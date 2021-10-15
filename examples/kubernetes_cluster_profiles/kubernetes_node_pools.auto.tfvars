#__________________________________________________________
#
# Kubernetes Node Pools Variables
#__________________________________________________________

kubernetes_node_pools = {
  "#Cluster#_k8s_cl02_ctrl_plane" = {
    action                  = "No-op"
    description             = "#Cluster# Kubernetes Cluster02 Control Plane"
    desired_size            = 1
    ip_pool_moid            = "#Cluster#_pool_v4"
    kubernetes_cluster_moid = "#Cluster#_k8s_cl02"
    kubernetes_labels = [
      {
        key   = "Node Pool"
        value = "Control Plane"
      }
    ]
    kubernetes_version_moid = "#Cluster#_v1_19_5"
    max_size                = 3
    min_size                = 1
    node_type               = "ControlPlane"
    organization            = "default"
    vm_infra_config_moid    = "#Cluster#_vm_infra"
    vm_instance_type_moid   = "#Cluster#_small"
  }
  "#Cluster#_k8s_cl02_worker01" = {
    action                  = "No-op"
    description             = "#Cluster# Kubernetes Cluster01 Worker Pool 1"
    desired_size            = 1
    ip_pool_moid            = "#Cluster#_pool_v4"
    kubernetes_cluster_moid = "#Cluster#_k8s_cl02"
    kubernetes_labels = [
      {
        key   = "Node Pool"
        value = "Worker Pool 1"
      }
    ]
    kubernetes_version_moid = "#Cluster#_v1_19_5"
    max_size                = 3
    min_size                = 1
    node_type               = "Worker"
    organization            = "default"
    vm_infra_config_moid    = "#Cluster#_vm_infra"
    vm_instance_type_moid   = "#Cluster#_small"
  }
}
