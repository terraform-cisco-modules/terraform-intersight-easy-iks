#______________________________________________
#
# Add-ons Policy Variables
#______________________________________________

variable "addons_policies" {
  default = {
    default = {
      chart_name        = ""
      chart_version     = ""
      version           = ""
      description       = ""
      install_strategy  = "Always"
      override_sets     = []
      overrides         = ""
      release_name      = ""
      release_namespace = ""
      tags              = []
      upgrade_strategy  = "UpgradeOnly"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Add-ons Variable Map.  Add-ons Options are {ccp-monitor|kubernetes-dashboard|ssm} currently.
  Key - Name of the Add-ons Policy
  * description - A description for the policy.
  * install_strategy - Add-ons install strategy to determine whether an addon is installed if not present.
    - None - Unspecified install strategy.
    - NoAction - No install action performed.
    - InstallOnly - Only install in green field. No action in case of failure or removal.
    - Always - Attempt install if chart is not already installed.
  * overrides - 
  * release_name - Name for the helm release.
  * release_namespace - Namespace for the helm release.
  * tags - List of key/value Attributes to Assign to the Policy.
  * upgrade_strategy - Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.
    - None - Unspecified upgrade strategy.
    - NoAction - This choice enables No upgrades to be performed.
    - UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.
    - ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.
    - AlwaysReinstall - Always remove older release and reinstall.
  * version - Release version of the Helm Chart
  EOT
  type = map(object(
    {
      chart_name        = optional(string)
      chart_version     = optional(string)
      description       = optional(string)
      install_strategy  = optional(string)
      override_sets     = optional(list(map(string)))
      overrides         = optional(string)
      release_name      = optional(string)
      release_namespace = optional(string)
      tags              = optional(list(map(string)))
      upgrade_strategy  = optional(string)
      version           = optional(string)
    }
  ))
}


#__________________________________________________________________
#
# Intersight Kubernetes Add-ons Policy
# GUI Location: Policies > Create Policy > Add-ons
#__________________________________________________________________

data "intersight_kubernetes_addon_definition" "addons" {
  for_each              = local.addons_policies
  name                  = each.value.chart_name != "" ? each.value.chart_name : each.key
  additional_properties = each.value.chart_version != "" ? jsonencode({ "Version" = "${each.value.chart_version}" }) : ""
}

resource "intersight_kubernetes_addon_policy" "addons" {
  depends_on = [
    data.intersight_kubernetes_addon_definition.addons
  ]
  for_each    = local.addons_policies
  description = each.value.description != "" ? each.value.description : "Kubernetes Add-ons Policy for ${each.key}."
  name        = each.key
  # overrides   = each.value.overrides
  addon_configuration {
    install_strategy  = each.value.install_strategy
    release_name      = each.value.release_name != "" ? each.value.release_name : each.key
    override_sets     = each.value.override_sets
    overrides         = each.value.overrides
    release_namespace = each.value.release_namespace
    upgrade_strategy  = each.value.upgrade_strategy
  }
  addon_definition {
    moid = data.intersight_kubernetes_addon_definition.addons[each.key].results.0.moid
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
