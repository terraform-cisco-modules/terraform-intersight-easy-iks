#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

virtual_machine_infra_config = {
  "#Cluster#_vm_infra" = {
    organization          = "default"
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["prod|nets|Panther_VM1"]
    vsphere_resource_pool = "IKS"
    vsphere_target        = "#Cluster#-vcenter.rich.ciscolabs.com"
  }
}
