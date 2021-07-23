#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

# endpoint     = "https://intersight.com"
organization = "Wakanda"
secretkey    = "../../../../intersight.secret"
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
tags        = [{ key = "Module", value = "terraform-iks-iwo" }, { key = "Owner", value = "tyscott" }]

ip_pools = {"pool_1":{"from":101,"gateway":"10.96.101.1/24","name":null,"size":99}}
# ip_pools = {
#   pool_1 = {
#     from    = 101
#     gateway = "10.96.101.1/24"
#     # name    = "{tenant_name}_ip_pool"
#     size = 99
#     tags = []
#   }
# }

k8s_trusted_registry = {
  unsigned = ["10.101.128.128"]
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
