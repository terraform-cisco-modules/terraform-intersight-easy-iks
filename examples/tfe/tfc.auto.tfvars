#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

agent_pools       = ["Richfield_Agents"]
terraform_version = "1.1.8"
# tfc_email         = "tyscott@cisco.com"
tfc_organization = "Cisco-Richfield-Lab"
vcs_repo         = "scotttyso/terraform-intersight-easy-iks"
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
# tfc_oauth_token = "value"


#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

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
# Workspaces to Create
#__________________________________________________________

workspaces = {
  "Wakanda_IKS_policies" = {
    auto_apply          = true
    description         = "Wakanda Kubernetes Policies."
    global_remote_state = true
    working_directory   = "modules/kubernetes_policies"
    workspace_type      = "policies"
  }
  "Wakanda_IKS_clusters" = {
    auto_apply          = true
    description         = "Wakanda Intersight Kubernetes Service Clusters"
    global_remote_state = true
    working_directory   = "modules/kubernetes_cluster_profiles"
    workspace_type      = "cluster"
    vcs_repo            = [{ identifier = "scotttyso/terraform-intersight-easy-iks" }]
  }
  "Wakanda_kubeconfigs" = {
    auto_apply          = true
    description         = "Wakanda Intersight Kubernetes Service kubeconfigs."
    global_remote_state = true
    working_directory   = "modules/kubeconfigs"
    workspace_type      = "kubeconfig"
  }
  "Wakanda_app_hello" = {
    agent_pool        = "Richfield_Agents"
    auto_apply        = true
    description       = "Wakanda Intersight Kubernetes Service App Hello Deployments."
    execution_mode    = "agent"
    working_directory = "modules/app_hello"
    workspace_type    = "app"
  }
  "Wakanda_iwo" = {
    agent_pool        = "Richfield_Agents"
    auto_apply        = true
    description       = "Wakanda Intersight Kubernetes Service IWO Deployments."
    execution_mode    = "agent"
    working_directory = "modules/iwo"
    workspace_type    = "app"
  }
}
