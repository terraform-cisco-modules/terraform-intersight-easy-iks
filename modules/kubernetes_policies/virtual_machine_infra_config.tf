#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

variable "virtual_machine_infra_config" {
  default = {
    default = {
      description           = ""
      organization          = "default"
      tags                  = []
      vsphere_cluster       = "default"
      vsphere_datastore     = "datastore1"
      vsphere_portgroup     = ["VM Network"]
      vsphere_resource_pool = ""
      vsphere_target        = ""
    }
  }
  description = <<-EOT
  Intersight Kubernetes Virtual Machine Infra Config Policy Variable Map.
  Key - Name of the Virtual Machine Infra Config Policy
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  * vsphere_cluster - vSphere Cluster to assign the K8S Cluster Deployment.
  * vsphere_datastore - vSphere Datastore to assign the K8S Cluster Deployment.r\n
  * vsphere_portgroup - vSphere Port Group to assign the K8S Cluster Deployment.r\n
  * vsphere_resource_pool - vSphere Resource Pool to assign the K8S Cluster Deployment.r\n
  * vsphere_target - Name of the vSphere Target discovered in Intersight, to provision the cluster on.
  EOT
  type = map(object(
    {
      description           = optional(string)
      organization          = optional(string)
      tags                  = optional(list(map(string)))
      vsphere_cluster       = string
      vsphere_datastore     = string
      vsphere_portgroup     = list(string)
      vsphere_resource_pool = optional(string)
      vsphere_target        = string
    }
  ))
}

variable "vsphere_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}


#______________________________________________
#
# Virtual Machine Infra Config Policy Module
#______________________________________________

module "virtual_machine_infra_config" {
  source                = "terraform-cisco-modules/imm/intersight//modules/virtual_machine_infra_config"
  for_each              = local.virtual_machine_infra_config
  description           = each.value.description != "" ? each.value.description : "${each.key} Virtual Machine Infra Config Policy."
  name                  = each.key
  org_moid              = local.org_moids[each.value.organization].moid
  tags                  = each.value.tags != null ? each.value.tags : local.tags
  vsphere_cluster       = each.value.vsphere_cluster
  vsphere_datastore     = each.value.vsphere_datastore
  vsphere_password      = var.vsphere_password
  vsphere_portgroup     = each.value.vsphere_portgroup
  vsphere_resource_pool = each.value.vsphere_resource_pool
  vsphere_target        = each.value.vsphere_target
}
