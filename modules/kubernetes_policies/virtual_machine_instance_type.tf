#______________________________________________
#
# Kubernetes Virtual Machine Instance Variables
#______________________________________________

variable "virtual_machine_instance_type" {
  default = {
    default = {
      cpu              = 4
      description      = ""
      memory           = 16384
      system_disk_size = 40
      tags             = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Virtual Machine Instance Type Policy Variable Map.
  Key - Name of the Virtual Machine Instance Type Policy
  * cpu - Number of CPUs allocated to virtual machine.  Range is 1-40.
  * description - A description for the policy.
  * memory - Virtual machine memory defined in mebibytes (MiB).  Range is 1-4177920.
  * system_disk_size - Ephemeral disk capacity to be provided with units example - 10 for 10 Gigabytes.
  * tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      cpu              = optional(number)
      description      = optional(string)
      memory           = optional(number)
      system_disk_size = optional(number)
      tags             = optional(list(map(string)))
    }
  ))
}

#________________________________________________________________________
#
# Intersight Kubernetes Virtual Machine Instance Type Policy
# GUI Location: Policies > Create Policy > Virtual Machine Instance Type
#________________________________________________________________________

resource "intersight_kubernetes_virtual_machine_instance_type" "virtual_machine_instance_type" {
  for_each    = local.virtual_machine_instance_type
  cpu         = each.value.cpu
  description = each.value.description != "" ? each.value.description : "${each.key} Virtual Machine Instance Policy."
  disk_size   = each.value.system_disk_size
  memory      = each.value.memory
  name        = each.key
  organization {
    moid        = local.org_moid
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
