#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

agent_pool        = "Richfield_Agents"
terraform_version = "1.0.3"
# tfc_email         = "tyscott@cisco.com"
tfc_organization = "Cisco-Richfield-Lab"
vcs_repo         = "scotttyso/terraform-intersight-iks-iwo"
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

/*
This module supports multiple organizations.  If you wanted to assign default and prod it would be ["default","prod"].
*/
organizations = ["Wakanda"]
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
# Kubernetes Policy Variables
#__________________________________________________________

tags = [{ key = "Module", value = "terraform-intersight-iks-iwo" }, { key = "Owner", value = "tyscott" }]

#__________________________________________________________
#
# Workspaces to Create
#__________________________________________________________

workspaces = {
  "Wakanda_k8s_policies" = {
    auto_apply        = true
    description       = "Intersight Kubernetes Policies Workspace."
    working_directory = "modules/k8s_policies"
    workspace_type    = "k8s_policies"
  }
  "Tenant1_cl01" = {
    auto_apply        = true
    create_app_hello  = true
    create_iwo        = true
    description       = "Tenant1_cl01 - Intersight Kubernetes Service Workspace."
    working_directory = "modules/iks"
    workspace_type    = "iks"
  }
  "Tenant2_cl02" = {
    auto_apply        = true
    create_iwo        = true
    description       = "Tenant1_cl02 - Intersight Kubernetes Service Workspace."
    working_directory = "modules/iks"
    workspace_type    = "iks"
  }
}

ip_pools = {
  Tenant1_pool_1 = {
    dns_servers_v4 = ["10.101.128.15", "10.101.128.16"]
    from           = 101
    gateway        = "10.92.110.1/24"
    organization   = "Wakanda"
    size           = 99
    tags           = []
  }
  Tenant2_pool_1 = {
    dns_servers_v4 = ["10.101.128.15", "10.101.128.16"]
    from           = 101
    gateway        = "10.96.110.1/24"
    organization   = "Wakanda"
    size           = 99
    tags           = []
  }
}

k8s_addon_policies = {
  ccp-monitor = {
    organization = "Wakanda"
    # This is mostly empty because I am accepting all the default values
  }
  kubernetes-dashboard = {
    install_strategy = "InstallOnly"
    organization     = "Wakanda"
    upgrade_strategy = "AlwaysReinstall"
  }
}

k8s_network_cidr = {
  Tenant1_network_cidr = {
    organization = "Wakanda"
    # This is mostly empty because I am accepting all the default values
  }
  Tenant2_network_cidr = {
    cidr_pod     = "198.18.0.0/16"
    cidr_service = "198.19.0.0/16"
    organization = "Wakanda"
    # This is mostly empty because I am accepting all the default values
  }
}

k8s_nodeos_config = {
  Wakanda_nodeos_config = {
    dns_servers_v4 = ["10.101.128.15", "10.101.128.16"]
    domain_name    = "rich.ciscolabs.com"
    #  If ntp_servers is not set, dns_servers will be used as NTP servers
    # ntp_servers = []
    # For a List of timezones see https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md.
    organization = "Wakanda"
    timezone     = "America/New_York"
  }
}

k8s_trusted_create = true

k8s_trusted_registries = {
  Wakanda_registry = {
    organization = "Wakanda"
    unsigned     = ["10.101.128.128"]
  }
}

k8s_version_policies = {
  Wakanda_v1_19_5 = {
    organization = "Wakanda"
    # This is mostly empty because I am accepting all the default values
  }
}

k8s_vm_infra_config = {
  Tenant1_vm_infra = {
    organization          = "Wakanda"
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["Tenant1|nets|iks"]
    vsphere_resource_pool = "IKS"
    vsphere_target        = "wakanda-vcenter.rich.ciscolabs.com"
  }
  Tenant2_vm_infra = {
    organization          = "Wakanda"
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["Tenant2|nets|iks"]
    vsphere_resource_pool = "IKS"
    vsphere_target        = "wakanda-vcenter.rich.ciscolabs.com"
  }
}

k8s_vm_instance_type = {
  Wakanda_large = {
    cpu          = 12
    disk         = 80
    memory       = 32768
    organization = "Wakanda"
  }
  Wakanda_medium = {
    cpu          = 8
    disk         = 60
    memory       = 24576
    organization = "Wakanda"
  }
  Wakanda_small = {
    organization = "Wakanda"
    # This is empty because I am accepting all the default values
  }
}


#__________________________________________________________
#
# Cluster Variables
#__________________________________________________________

iks_cluster = {
  Tenant1_cl01 = {
    action_cluster                  = "Deploy" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    control_plane_desired_size      = 3
    control_plane_max_size          = 3
    ip_pool_moid                    = "Tenant1_pool_1"
    k8s_addon_policy_moid           = ["ccp-monitor", "kubernetes-dashboard"]
    k8s_network_cidr_moid           = "Tenant1_network_cidr"
    k8s_nodeos_config_moid          = "Wakanda_nodeos_config"
    k8s_registry_moid               = "Wakanda_registry"
    k8s_runtime_moid                = ""
    k8s_version_moid                = "Wakanda_v1_19_5"
    k8s_vm_infra_moid               = "Tenant1_vm_infra"
    k8s_vm_instance_type_ctrl_plane = "Wakanda_small"
    k8s_vm_instance_type_worker     = "Wakanda_large"
    load_balancers                  = 3
    organization                    = "Wakanda"
    ssh_key                         = "ssh_key_1"
    ssh_user                        = "iksadmin"
    tags                            = []
    wait_for_complete               = false
    worker_desired_size             = 3
    worker_max_size                 = 6
  }
  Tenant2_cl01 = {
    action_cluster                  = "Deploy" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    control_plane_desired_size      = 3
    control_plane_max_size          = 3
    ip_pool_moid                    = "Tenant2_pool_1"
    k8s_addon_policy_moid           = ["ccp-monitor", "kubernetes-dashboard"]
    k8s_network_cidr_moid           = "Tenant2_network_cidr"
    k8s_nodeos_config_moid          = "Wakanda_nodeos_config"
    k8s_registry_moid               = "Wakanda_registry"
    k8s_runtime_moid                = ""
    k8s_version_moid                = "Wakanda_v1_19_5"
    k8s_vm_infra_moid               = "Tenant2_vm_infra"
    k8s_vm_instance_type_ctrl_plane = "Wakanda_small"
    k8s_vm_instance_type_worker     = "Wakanda_large"
    load_balancers                  = 3
    organization                    = "Wakanda"
    ssh_key                         = "ssh_key_1"
    ssh_user                        = "iksadmin"
    tags                            = []
    wait_for_complete               = false
    worker_desired_size             = 3
    worker_max_size                 = 6
  }
}
