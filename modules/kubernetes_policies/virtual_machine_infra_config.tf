#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

variable "virtual_machine_infra_config" {
  default = {
    default = {
      description = ""
      tags        = []
      target      = ""
      virtual_infrastructure = [
        {
          cluster       = "default"
          datastore     = "datastore1"
          portgroup     = ["VM Network"]
          resource_pool = ""
          type          = "vmware"
        }
      ]
    }
  }
  description = <<-EOT
  Intersight Kubernetes Virtual Machine Infra Config Policy Variable Map.
  Key - Name of the Virtual Machine Infra Config Policy
  * description - A description for the policy.
  * tags - List of key/value Attributes to Assign to the Policy.
  * target - Name of the IWE or vSphere Target discovered in Intersight, to provision the cluster to.
  * vsphere_cluster - vSphere Cluster to assign the K8S Cluster Deployment.
  * vsphere_datastore - vSphere Datastore to assign the K8S Cluster Deployment.r\n
  * vsphere_portgroup - vSphere Port Group to assign the K8S Cluster Deployment.r\n
  * vsphere_resource_pool - vSphere Resource Pool to assign the K8S Cluster Deployment.r\n
  EOT
  type = map(object(
    {
      description = optional(string)
      tags        = optional(list(map(string)))
      target      = string
      virtual_infrastructure = list(object(
        {
          cluster       = string
          datastore     = string
          portgroup     = list(string)
          resource_pool = optional(string)
          type          = optional(string)
        }
      ))
    }
  ))
}

variable "vsphere_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}


#_______________________________________________________________________
#
# Intersight Kubernetes Virtual Machine Infra Config Policy
# GUI Location: Policies > Create Policy > Virtual Machine Infra Config
#_______________________________________________________________________

data "intersight_asset_target" "target" {
  for_each = local.virtual_machine_infra_config
  name     = each.value.target
}

resource "intersight_kubernetes_virtual_machine_infra_config_policy" "virtual_machine_infra_config" {
  depends_on = [
    data.intersight_asset_target.target
  ]
  for_each    = local.virtual_machine_infra_config
  description = each.value.description != "" ? each.value.description : "${each.key} Virtual Machine Infra Config Policy."
  name        = each.key
  organization {
    moid        = local.org_moid
    object_type = "organization.Organization"
  }
  target {
    object_type = "asset.DeviceRegistration"
    moid        = data.intersight_asset_target.target[each.key].results.0.registered_device[0].moid
  }
  dynamic "vm_config" {
    for_each = { for k, v in each.value.virtual_infrastructure : k => v if v.type == "vmware" }
    content {
      additional_properties = jsonencode({
        Datastore    = vm_config.value.datastore
        Cluster      = vm_config.value.cluster
        Passphrase   = var.vsphere_password
        ResourcePool = vm_config.value.resource_pool
      })
      interfaces  = vm_config.value.portgroup
      object_type = "kubernetes.EsxiVirtualMachineInfraConfig"

    }
  }
  dynamic "vm_config" {
    for_each = { for k, v in each.value.virtual_infrastructure : k => v if v.type == "iwe" }
    content {
      additional_properties = jsonencode({
        Datastore    = vm_config.value.datastore
        Cluster      = vm_config.value.cluster
        Passphrase   = var.vsphere_password
        ResourcePool = vm_config.value.resource_pool
      })
      network_interfaces = vm_config.value.network_interfaces

    }
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
