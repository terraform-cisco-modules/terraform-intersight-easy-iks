#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

virtual_machine_infra_config = {
  Wakanda_vm_infra = {
    organization          = "Wakanda"
    vsphere_cluster       = "Panther"
    vsphere_datastore     = "NVMe_DS1"
    vsphere_portgroup     = ["prod|nets|Panther_VM1"]
    vsphere_resource_pool = "IKS"
    vsphere_target        = "wakanda-vcenter.rich.ciscolabs.com"
  }
}
