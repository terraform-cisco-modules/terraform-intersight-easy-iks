#______________________________________________
#
# Network CIDR Policy Variables
#______________________________________________

variable "network_cidr_policies" {
  default = {
    default = {
      cni_type         = "Calico"
      description      = ""
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
  * pod_network_cidr - CIDR block to allocate pod network IP addresses from.
  * service_cidr - Pod CIDR Block to be used to assign Pod IP Addresses.
  * tags - tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      cni_type         = optional(string)
      description      = optional(string)
      pod_network_cidr = optional(string)
      service_cidr     = optional(string)
      tags             = optional(list(map(string)))
    }
  ))
}


#__________________________________________________________________
#
# Intersight Kubernetes Network CIDR Policy
# GUI Location: Policies > Create Policy > Network CIDR
#__________________________________________________________________

resource "intersight_kubernetes_network_policy" "network_cidr" {
  for_each         = local.network_cidr_policies
  cni_type         = each.value.cni_type
  description      = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Network CIDR Policy."
  name             = each.key
  pod_network_cidr = each.value.pod_network_cidr
  service_cidr     = each.value.service_cidr
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
