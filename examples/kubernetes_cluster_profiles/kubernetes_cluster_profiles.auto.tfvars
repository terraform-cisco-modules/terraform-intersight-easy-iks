#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

tfc_organization = "Cisco-Richfield-Lab"
tfc_workspace    = "Your_Workspace"
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
# secretkey    = "~/intersight.secret"
/*
  To export the Secret Key via an Environment Variable the format is as follows (Note: they are not quotation marks, but escape characters):
  - export TF_VAR_secretkey=`cat ~/intersight.secret`
  Either way will work in this case as we are not posting the contents of the file here.
*/
/*
  We highly recommend that for the apikey you use an environment variable for input:
  - export TF_VAR_apikey="abcdefghijklmnopqrstuvwxyz.0123456789"
*/
# apikey = "value"

#__________________________________________________________
#
# Kubernetes Cluster Profile Variables
#__________________________________________________________

kubernetes_cluster_profiles = {
  "#Tenant#_k8s_cl02" = {
    action                             = "Deploy" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons_policy_moid                 = ["ccp-monitor", "kubernetes-dashboard"]
    container_runtime_moid             = ""
    ip_pool_moid                       = "#Tenant#_pool_v4"
    network_cidr_moid                  = "#Tenant#_network_cidr"
    nodeos_configuration_moid          = "#Tenant#_nodeos_config"
    load_balancer_count                = 3
    organization                       = "default"
    ssh_public_key                     = "ssh_public_key_1"
    ssh_user                           = "iksadmin"
    tags                               = []
    trusted_certificate_authority_moid = "#Tenant#_registry"
    wait_for_complete                  = false
    node_pools = {
      "control_plane" = {
        action       = "No-op"
        description  = "Control Plane"
        desired_size = 1
        # ip_pool_moid            = "#Tenant#_pool_v4" # can Define if wanting different than the cluster
        kubernetes_labels = [
          {
            key   = "Node Pool"
            value = "Control Plane"
          }
        ]
        kubernetes_version_moid = "#Tenant#_v1_19_5"
        max_size                = 3
        min_size                = 1
        node_type               = "ControlPlane"
        organization            = "default"
        vm_infra_config_moid    = "#Tenant#_vm_infra"
        vm_instance_type_moid   = "#Tenant#_small"
      }
      "worker01" = {
        action       = "No-op"
        description  = "#Tenant# Kubernetes Cluster01 Worker Pool 1"
        desired_size = 1
        kubernetes_labels = [
          {
            key   = "Node Pool"
            value = "Worker Pool 1"
          }
        ]
        kubernetes_version_moid = "#Tenant#_v1_19_5"
        max_size                = 3
        min_size                = 1
        node_type               = "Worker"
        vm_infra_config_moid    = "#Tenant#_vm_infra"
        vm_instance_type_moid   = "#Tenant#_small"
      }

    }
  }
}
