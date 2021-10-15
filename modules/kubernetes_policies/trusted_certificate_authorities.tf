#__________________________________________________
#
# Trusted Certificate Authorities Policy Variables
#__________________________________________________

variable "trusted_certificate_authorities" {
  default = {
    default = {
      description  = ""
      organization = "default"
      root_ca      = []
      tags         = []
      unsigned     = []
    }
  }
  description = <<-EOT
  Intersight Kubernetes Trusted Registry Policy Variable Map.
  Key - Name of the Trusted Certificate Authorities Policy
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * root_ca_registries - The list of root CA certificates to trust.
  * tags - List of key/value Attributes to Assign to the Policy.
  * unsigned_registries - The list of unsigned registries to allow docker trust..
  EOT
  type = map(object(
    {
      description         = optional(string)
      organization        = optional(string)
      root_ca_registries  = optional(list(string))
      tags                = optional(list(map(string)))
      unsigned_registries = optional(list(string))
    }
  ))
}


#______________________________________________
#
# Trusted Certificate Authorities Policy Module
#______________________________________________

module "trusted_certificate_authorities" {
  source              = "terraform-cisco-modules/imm/intersight//modules/trusted_certificate_authorities"
  for_each            = local.trusted_certificate_authorities
  description         = each.value.description != "" ? each.value.description : "${each.key} Trusted Registry Policy."
  name                = each.key
  org_moid            = local.org_moids[each.value.organization].moid
  root_ca_registries  = each.value.root_ca_registries != [] ? each.value.root_ca_registries : []
  unsigned_registries = each.value.unsigned_registries != [] ? each.value.unsigned_registries : []
  tags                = each.value.tags != [] ? each.value.tags : local.tags
}
