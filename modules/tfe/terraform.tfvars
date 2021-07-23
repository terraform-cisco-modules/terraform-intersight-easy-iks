#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

agent_pool        = "Richfield_Agents"
terraform_version = "1.0.0"
tfc_email         = "tyscott@cisco.com"
tfc_organization  = "Cisco-Richfield-Lab"
vcs_repo          = "scotttyso/terraform-iks"
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
secretkey    = "../../intersight.secret"
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

domain_name = "rich.ciscolabs.com"
dns_servers = ["10.101.128.15", "10.101.128.16"]


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

tenant_name         = "tyscott"
tags                = [{ key = "Terraform", value = "Module" }, { key = "Owner", value = "tyscott" }]
unsigned_registries = ["10.101.128.128"]

cluster_variables = {
  cluster_1 = {
    addons_list           = ["ccp-monitor", "kubernetes-dashboard"]
    cluster_name          = "cl1"
    ip_pool_gateway       = "10.96.110.1"
    ip_pool_from          = "10.96.110.20"
    vsphere_target        = "wakanda-vcenter.rich.ciscolabs.com"
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["prod|nets|Panther_VM1"]
    vsphere_resource_pool = "IKS"

  }
}
