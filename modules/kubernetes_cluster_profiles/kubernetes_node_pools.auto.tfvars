#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

# agent_pool        = "Richfield_Agents"
# terraform_version = "1.0.3"
# tfc_email         = "tyscott@cisco.com"
tfc_organization = "Cisco-Richfield-Lab"
# vcs_repo         = "scotttyso/terraform-intersight-iks-iwo"
/*
  We highly recommend that for the terraform_cloud_token you use an environment variable for input:
  - export TF_VAR_terraform_cloud_token="abcdefghijklmnopqrstuvwxyz.0123456789"
  If you still want to move forward with it in this file, uncomment the line below, and input your value.
*/
# terraform_cloud_token = "value"
/*
  We highly recommend that for the tfc_oath_token you use an environment variable for input; Like:
  - export TF_VAR_tfc_oath_token="abcdefghijklmnopqrstuvwxyz.0123456789"
  If you still want to move forward with it in this file, uncomment the line below, and input your value.
*/
# tfc_oath_token = "value"


#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

# endpoint     = "https://intersight.com"
# secretkey    = "../../../../intersight.secret"
/*
  To export the Secret Key via an Environment Variable the format is as follows (Note: they are not quotation marks, but escape characters):
  - export TF_VAR_secretkey=`cat ../../intersight.secret`
  Either way will work in this case as we are not posting the contents of the file here.
*/
/*
  We highly recommend that for the apikey you use an environment variable for input:
  - export TF_VAR_apikey="abcdefghijklmnopqrstuvwxyz.0123456789"
*/
# apikey = "value"

#__________________________________________________________
#
# Kubernetes Node Pools Variables
#__________________________________________________________

kubernetes_node_pools = {
  "wakanda_k8s_cl01_ctrl_plane" = {
    action = "No-op"
    description = "Wakanda Kubernetes Cluster01 Control Plane"
    desired_size = 1
    ip_pool_moid = "Wakanda_pool_v4"
    kubernetes_cluster_moid = "wakanda_k8s_cl01"
    kubernetes_labels = [
      {
        key = "Node Pool"
        value = "Control Plane"
      }
    ]
    kubernetes_version_moid = "Wakanda_v1_19_5"
    max_size = 3
    min_size = 1
    node_type = "ControlPlane"
    organization = "Wakanda"
    vm_infra_config_moid = "Wakanda_vm_infra"
    vm_instance_type_moid = "Wakanda_small"
  }
  "wakanda_k8s_cl01_worker01" = {
    action = "No-op"
    description = "Wakanda Kubernetes Cluster01 Worker Pool 1"
    desired_size = 1
    ip_pool_moid = "Wakanda_pool_v4"
    kubernetes_cluster_moid = "wakanda_k8s_cl01"
    kubernetes_labels = [
      {
        key = "Node Pool"
        value = "Worker Pool 1"
      }
    ]
    kubernetes_version_moid = "Wakanda_v1_19_5"
    max_size = 3
    min_size = 1
    node_type = "Worker"
    organization = "Wakanda"
    vm_infra_config_moid = "Wakanda_vm_infra"
    vm_instance_type_moid = "Wakanda_small"
  }
}
