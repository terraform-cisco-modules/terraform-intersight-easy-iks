#______________________________________________
#
# Kubernetes Node OS Config Variables
#______________________________________________

variable "nodeos_configuration_policies" {
  default = {
    default = {
      description  = ""
      dns_servers  = ["208.67.220.220", "208.67.222.222"]
      dns_suffix   = "example.com"
      ntp_servers  = []
      organization = "default"
      tags         = []
      timezone     = "Etc/GMT"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Node OS Configuration Policy Variable Map.
  Key - Name of the Node OS Configuration Policy
  * description - A description for the policy.
  * dns_servers - DNS Servers for the Kubernetes Node OS Configuration Policy.
  * dns_suffix - Domain Name for the Kubernetes Node OS Configuration Policy.
  * ntp_servers - NTP Servers for the Kubernetes Node OS Configuration Policy.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * tags - tags - List of key/value Attributes to Assign to the Policy.
  * timezone - The timezone of the node's system clock.  For a List of supported timezones see the following URL:
    - https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md.
  EOT
  type = map(object(
    {
      description  = optional(string)
      dns_servers  = optional(list(string))
      dns_suffix   = optional(string)
      ntp_servers  = optional(list(string))
      organization = optional(string)
      tags         = optional(list(map(string)))
      timezone     = optional(string)
    }
  ))
}


#______________________________________________
#
# Intersight Kubernetes Node OS Config Policy
#______________________________________________

module "nodeos_configuration_policies" {
  source      = "terraform-cisco-modules/imm/intersight//modules/nodeos_configuration_policies"
  for_each    = local.nodeos_configuration_policies
  description = each.value.description != "" ? each.value.description : "${each.key} Kubernetes Network CIDR Policy."
  dns_servers = each.value.dns_servers
  dns_suffix  = each.value.dns_suffix
  name        = each.key
  ntp_servers = each.value.ntp_servers != [] ? each.value.ntp_servers : each.value.dns_servers
  org_moid    = local.org_moids[each.value.organization].moid
  tags        = each.value.tags != null ? each.value.tags : local.tags
  timezone    = each.value.timezone
}
