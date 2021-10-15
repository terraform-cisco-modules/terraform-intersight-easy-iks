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
# Kubernetes Cluster Profile Variables
#__________________________________________________________

kubernetes_cluster_profiles = {
  "wakanda_kubernetes_cl01" = {
    action_cluster                      = "No-op" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons_policy_moid                  = ["ccp-monitor", "kubernetes-dashboard"]
    container_runtime_moid              = ""
    control_plane_desired_size          = 1
    control_plane_max_size              = 3
    control_plane_vm_instance_type_moid = "Wakanda_small"
    ip_pool_moid                        = "Wakanda_pool_v4"
    network_cidr_moid                   = "Wakanda_network_cidr"
    nodeos_configuration_moid           = "Wakanda_nodeos_config"
    kubernetes_version_moid             = "Wakanda_v1_19_5"
    load_balancers                      = 3
    organization                        = "Wakanda"
    ssh_key                             = "ssh_key_1"
    ssh_user                            = "iksadmin"
    tags                                = []
    trusted_certificate_authority_moid  = "Wakanda_registry"
    wait_for_complete                   = false
    worker_desired_size                 = 1
    worker_max_size                     = 4
    worker_vm_instance_type_moid        = "Wakanda_small"
    vm_infra_config_moid                = "Wakanda_vm_infra"
  }
}
