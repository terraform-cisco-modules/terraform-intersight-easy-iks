#______________________________________________
#
# Network CIDR Policy Variables
#______________________________________________

# Terraform Cloud JSON Parse Mode
variable "network_cidr_policies" {
  description = "Please Refer to OSS Model Below for Variable Details"
  type        = string
}

# Terraform OSS Mode
# variable "network_cidr_policies" {
#   default = {
#     default = {
#       cidr_pod     = "100.64.0.0/16"
#       cidr_service = "100.65.0.0/16"
#       cni_type     = "Calico"
#       description  = ""
#       organization = "default"
#       tags         = []
#     }
#   }
#   description = <<-EOT
#   Intersight Kubernetes Network CIDR Policy Variable Map.
#   Key - Name of the Network CIDR Policy.
#   * cidr_pod - CIDR block to allocate pod network IP addresses from.
#   * cidr_service - Pod CIDR Block to be used to assign Pod IP Addresses.
#   * cni_type - Supported CNI type. Currently we only support Calico.
#     - Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin
#     - Aci - Cisco ACI Container Network Interface plugin.
#   * description - A description for the policy.
#   * organization - Name of the Intersight Organization to assign this pool to.
#     - https://intersight.com/an/settings/organizations/
#   * tags - tags - List of key/value Attributes to Assign to the Policy.
#   EOT
#   type = map(object(
#     {
#       cidr_pod     = optional(string)
#       cidr_service = optional(string)
#       cni_type     = optional(string)
#       description  = optional(string)
#       organization = optional(string)
#       tags         = optional(list(map(string)))
#     }
#   ))
# }


#______________________________________________
#
# Intersight Kubernetes Network CIDR Policy
#______________________________________________

module "network_cidr_policies" {
  source       = "terraform-cisco-modules/imm/intersight//modules/network_cidr_policies"
  for_each     = local.network_cidr_policies
  cidr_pod     = each.value.cidr_pod
  cidr_service = each.value.cidr_service
  cni_type     = each.value.cni_type
  description  = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Network CIDR Policy."
  org_moid     = local.org_moids[each.value.organization].moid
  name         = each.key
  tags         = each.value.tags != null ? each.value.tags : local.tags
}
