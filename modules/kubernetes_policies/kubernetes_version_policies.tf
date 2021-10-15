#______________________________________________
#
# Kubernetes Verison Policy Variables
#______________________________________________

variable "kubernetes_version_policies" {
  default = {
    default = {
      description  = ""
      organization = "default"
      tags         = []
      version      = "v1.19.5"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Version Policy Variable Map.
  Key - Name of the Kubernetes Version Policy
  * description - A description for the policy.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  * version - Desired Kubernetes version.  Options are:
    - v1.19.5
  EOT
  type = map(object(
    {
      description  = optional(string)
      organization = optional(string)
      tags         = optional(list(map(string)))
      version      = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Version Policy Module
#______________________________________________

module "kubernetes_version_policies" {
  source             = "terraform-cisco-modules/imm/intersight//modules/kubernetes_version_policies"
  for_each           = local.kubernetes_version_policies
  description        = each.value.description != "" ? each.value.description : "${each.key} Version Policy."
  name               = each.key
  org_moid           = local.org_moids[each.value.organization].moid
  kubernetes_version = each.value.version
  tags               = each.value.tags != [] ? each.value.tags : local.tags
}


