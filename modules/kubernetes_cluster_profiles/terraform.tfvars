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
# Cluster Variables
#__________________________________________________________
iks_cluster = {
  cluster02 = {
    action_cluster                  = "No-op" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    control_plane_desired_size      = 1
    control_plane_max_size          = 3
    ip_pool_moid                    = "Wakanda_pool_1"
    k8s_addon_policy_moid           = ["ccp-monitor", "kubernetes-dashboard"]
    k8s_network_cidr_moid           = "Wakanda_network_cidr"
    k8s_nodeos_config_moid          = "Wakanda_nodeos_config"
    k8s_registry_moid               = "Wakanda_registry"
    k8s_runtime_moid                = ""
    k8s_version_moid                = "Wakanda_v1_19_5"
    k8s_vm_infra_moid               = "Wakanda_vm_infra"
    k8s_vm_instance_type_ctrl_plane = "Wakanda_small"
    k8s_vm_instance_type_worker     = "Wakanda_small"
    load_balancers                  = 3
    organization                    = "Wakanda"
    ssh_key                         = "ssh_key_1"
    ssh_user                        = "iksadmin"
    tags                            = []
    wait_for_complete               = false
    worker_desired_size             = 1
    worker_max_size                 = 4
  }
}
