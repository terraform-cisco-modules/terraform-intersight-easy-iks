#______________________________________________
#
# Kubernetes Virtual Machine Instance Variables
#______________________________________________

# Terraform Cloud JSON Parse Mode
variable "virtual_machine_instance_type" {
  description = "Please Refer to OSS Model Below for Variable Details"
  type        = string
}

# Terraform OSS Mode
# variable "virtual_machine_instance_type" {
#   default = {
#     default = {
#       cpu          = 4
#       description  = ""
#       disk         = 40
#       memory       = 16384
#       organization = "default"
#       tags         = []
#     }
#   }
#   description = <<-EOT
#   Intersight Kubernetes Virtual Machine Instance Type Policy Variable Map.
#   Key - Name of the Virtual Machine Instance Type Policy
#   * cpu - Number of CPUs allocated to virtual machine.  Range is 1-40.
#   * description - A description for the policy.
#   * disk - Ephemeral disk capacity to be provided with units example - 10 for 10 Gigabytes.
#   * memory - Virtual machine memory defined in mebibytes (MiB).  Range is 1-4177920.
#   * organization - Name of the Intersight Organization to assign this pool to.
#     - https://intersight.com/an/settings/organizations/
#   * tags - List of key/value Attributes to Assign to the Policy.
#   EOT
#   type = map(object(
#     {
#       cpu          = optional(number)
#       description  = optional(string)
#       disk         = optional(number)
#       memory       = optional(number)
#       organization = optional(string)
#       tags         = optional(list(map(string)))
#     }
#   ))
# }

#______________________________________________
#
# Create the Kubernetes VM Instance Types
#______________________________________________

module "virtual_machine_instance_type" {
  source      = "terraform-cisco-modules/imm/intersight//modules/virtual_machine_instance_type"
  for_each    = local.virtual_machine_instance_type
  cpu         = each.value.cpu
  description = each.value.description != "" ? each.value.description : "${each.key} Virtual Machine Instance Policy."
  disk_size   = each.value.disk
  memory      = each.value.memory
  name        = each.key
  org_moid    = local.org_moids[each.value.organization].moid
  tags        = each.value.tags != [] ? each.value.tags : local.tags
}
