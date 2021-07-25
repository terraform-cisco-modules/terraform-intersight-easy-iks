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
# tfc_oath_token = "value"


#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

# endpoint     = "https://intersight.com"
organization = "Wakanda"
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
# DNS Variables
#__________________________________________________________

domain_name    = "rich.ciscolabs.com"
dns_servers_v4 = ["10.101.128.15", "10.101.128.16"]


#__________________________________________________________
#
# Time Variables
#__________________________________________________________
/*
  If ntp_servers is not set, dns_servers will be used as NTP servers
*/
# ntp_servers = []
# For a List of timezones see https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md.
timezone = "America/New_York"

#__________________________________________________________
#
# Cluster Variables
#__________________________________________________________

tenant_name = "Wakanda"
ws_tenant   = "wakanda"
tags        = [{ key = "Terraform", value = "Module" }, { key = "Owner", value = "tyscott" }]

ip_pools = {
  pool_1 = {
    from    = 101
    gateway = "10.96.101.1/24"
    name    = "Wakanda_ip_pool1"
    size    = 99
    tags    = []
  }
  pool_2 = {
    from    = 101
    gateway = "10.96.102.1/24"
    name    = "Wakanda_ip_pool2"
    size    = 99
    tags    = []
  }
  pool_3 = {
    from    = 101
    gateway = "10.96.103.1/24"
    name    = "Wakanda_ip_pool3"
    size    = 99
    tags    = []
  }
}

k8s_addons = {
  ccp-monitor = {
    # This is empty because I am accepting all the default values
  }
  kubernetes-dashboard = {
    install_strategy = "InstallOnly"
    upgrade_strategy = "AlwaysReinstall"
  }
}

k8s_trusted_create = true
k8s_trusted_registry = {
  default = {
    unsigned = ["10.101.128.128"]
  }
}

k8s_version = {
  default = {
    # This is empty because I am accepting all the default values
  }
}

k8s_vm_infra = {
  default = {
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["prod|nets|Panther_VM1"]
    vsphere_resource_pool = "IKS"
    vsphere_target        = "wakanda-vcenter.rich.ciscolabs.com"
  }
}

k8s_vm_instance = {
  large = {
    cpu    = 12
    disk   = 80
    memory = 32768
  }
  medium = {
    cpu    = 8
    disk   = 60
    memory = 24576
  }
  small = {
    # This is empty because I am accepting all the default values
  }
}

k8s_vm_network = {
  default = {
    # This is empty because I am accepting all the default values
  }
}

#__________________________________________________________
#
# Cluster Variables
#__________________________________________________________

iks_cluster = {
  cluster01 = {
    action_cluster             = "Deploy" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    addons                     = ["ccp-monitor", "kubernetes-dashboard"]
    control_plane_desired_size = 1
    control_plane_intance_moid = "small"
    control_plane_max_size     = 3
    ip_pool_moid               = "pool_1"
    k8s_vm_infra_moid          = "default"
    load_balancers             = 3
    ssh_key                    = "ssh_key_1"
    ssh_user                   = "iksadmin"
    registry_moid              = "default"
    runtime_moid               = []
    tags                       = []
    version_moid               = "default"
    vm_network_moid            = "default"
    wait_for_complete          = false
    worker_desired_size        = 1
    worker_intance_moid        = "small"
    worker_max_size            = 4
  }
}
