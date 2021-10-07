#______________________________________________
#
# Network CIDR Policy Variables
#______________________________________________

variable "network_cidr_policies" {
  default = {
    default = {
      cni_type         = "Calico"
      description      = ""
      organization     = "default"
      pod_network_cidr = "100.64.0.0/16"
      service_cidr     = "100.65.0.0/16"
      tags             = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Network CIDR Policy Variable Map.
  Key - Name of the Network CIDR Policy.
  * cni_type - Supported CNI type. Currently we only support Calico.
    - Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin
    - Aci - Cisco ACI Container Network Interface plugin.
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * pod_network_cidr - CIDR block to allocate pod network IP addresses from.
  * service_cidr - Pod CIDR Block to be used to assign Pod IP Addresses.
  * tags - tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      cni_type         = optional(string)
      description      = optional(string)
      organization     = optional(string)
      pod_network_cidr = optional(string)
      service_cidr     = optional(string)
      tags             = optional(list(map(string)))
    }
  ))
}


#______________________________________________
#
# Intersight Kubernetes Network CIDR Policy
#______________________________________________

module "network_cidr_policies" {
  source           = "terraform-cisco-modules/imm/intersight//modules/network_cidr_policies"
  for_each         = local.network_cidr_policies
  cni_type         = each.value.cni_type
  description      = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Network CIDR Policy."
  org_moid         = local.org_moids[each.value.organization].moid
  name             = each.key
  pod_network_cidr = each.value.pod_network_cidr
  service_cidr     = each.value.service_cidr
  tags             = each.value.tags != null ? each.value.tags : local.tags
}
