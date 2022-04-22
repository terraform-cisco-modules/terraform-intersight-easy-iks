#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

tfc_workspaces = [{
  backend      = "remote"
  organization = "Your_Organization"
  workspace    = "Your_k8s_cluster_Workspace"
}]
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
# secretkey    = "~/Downloads/SecretKey.txt"
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
  "panther-cl1" = {
    action                    = "No-op" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons_policies           = ["ccp-monitor", "kubernetes-dashboard"]
    certificate_configuration = false
    cluster_configuration = [{
      load_balancer_count = 3
      ssh_public_key      = 1
    }]
    container_runtime_policy = ""
    ip_pool                  = "iks"
    network_cidr_policy      = "Wakanda_CIDR"
    node_pools = {
      "Control_Plane" = {
        desired_size = 3
        ip_pool      = "iks"
        kubernetes_labels = [{
          "key"   = "environment"
          "value" = "production"
        }]
        kubernetes_version_policy = "v1.21.10"
        max_size                  = 3
        min_size                  = 2
        node_type                 = "ControlPlane"
        vm_infra_config_policy    = "Panther"
        vm_instance_type_policy   = "Small"
      }
      "Worker_g1" = {
        desired_size = 3
        ip_pool      = "iks"
        kubernetes_labels = [{
          "key"   = "environment"
          "value" = "production"
        }]
        kubernetes_version_policy = "v1.21.10"
        max_size                  = 5
        min_size                  = 3
        node_type                 = "Worker"
        vm_infra_config_policy    = "Panther"
        vm_instance_type_policy   = "Medium"
      }
    }
    nodeos_configuration_policy   = "Wakanda"
    trusted_certificate_authority = ""
    wait_for_completion           = false
  }
  "terminus-cl1" = {
    action                    = "No-op" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons_policies           = ["ccp-monitor", "kubernetes-dashboard"]
    certificate_configuration = false
    cluster_configuration = [{
      load_balancer_count = 3
      ssh_public_key      = 1
    }]
    container_runtime_policy = ""
    ip_pool                  = "iks"
    network_cidr_policy      = "Wakanda_CIDR"
    node_pools = {
      "Control_Plane" = {
        desired_size = 3
        ip_pool      = "iks"
        kubernetes_labels = [{
          "key"   = "environment"
          "value" = "pre-prod"
        }]
        kubernetes_version_policy = "v1.21.10"
        max_size                  = 3
        min_size                  = 2
        node_type                 = "ControlPlane"
        vm_infra_config_policy    = "Terminus"
        vm_instance_type_policy   = "Small"
      }
      "Worker_g1" = {
        desired_size = 3
        ip_pool      = "iks"
        kubernetes_labels = [{
          "key"   = "environment"
          "value" = "pre-prod"
        }]
        kubernetes_version_policy = "v1.21.10"
        max_size                  = 5
        min_size                  = 3
        node_type                 = "Worker"
        vm_infra_config_policy    = "Terminus"
        vm_instance_type_policy   = "Medium"
      }
    }
    nodeos_configuration_policy   = "Wakanda"
    trusted_certificate_authority = ""
    wait_for_completion           = false
  }
}