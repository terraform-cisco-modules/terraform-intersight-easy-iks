#______________________________________________
#
# Kubernetes Verison Policy Variables
#______________________________________________

variable "kubernetes_version_policies" {
  default = {
    default = {
      description = ""
      tags        = []
      version     = "v1.21.10"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Version Policy Variable Map.
  Key - Name of the Kubernetes Version Policy
  * description - A description for the policy.
  * tags - List of key/value Attributes to Assign to the Policy.
  * version - Desired Kubernetes version.  Options are:
    - v1.21.10
    - v1.20.14
  EOT
  type = map(object(
    {
      description = optional(string)
      tags        = optional(list(map(string)))
      version     = optional(string)
    }
  ))
}


#______________________________________________
#
# Kubernetes Version Policy Module
#______________________________________________

#Importing the Kubernetes Version available
data "intersight_kubernetes_version" "version" {
  for_each           = local.kubernetes_version_policies
  kubernetes_version = each.value.version
}

resource "intersight_kubernetes_version_policy" "kubernetes_version" {
  depends_on = [
    data.intersight_kubernetes_version.version
  ]
  for_each    = local.kubernetes_version_policies
  description = each.value.description != "" ? each.value.description : "${each.key} Version Policy."
  name        = each.key
  nr_version {
    moid        = data.intersight_kubernetes_version.version[each.key].results.0.moid
    object_type = "kubernetes.Version"
  }
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
