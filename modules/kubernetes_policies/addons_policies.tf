#______________________________________________
#
# Add-ons Policy Variables
#______________________________________________

variable "addons_policies" {
  default = {
    default = {
      description       = ""
      install_strategy  = "Always"
      organization      = "default"
      release_name      = ""
      release_namespace = ""
      tags              = []
      upgrade_strategy  = "UpgradeOnly"
    }
  }
  description = <<-EOT
  Intersight Kubernetes Service Add-ons Variable Map.  Add-ons Options are {ccp-monitor|kubernetes-dashboard} currently.
  Key - Name of the Add-ons Policy
  * description - A description for the policy.
  * install_strategy - Add-ons install strategy to determine whether an addon is installed if not present.
    - None - Unspecified install strategy.
    - NoAction - No install action performed.
    - InstallOnly - Only install in green field. No action in case of failure or removal.
    - Always - Attempt install if chart is not already installed.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * release_name - Name for the helm release.
  * release_namespace - Namespace for the helm release.
  * tags - List of key/value Attributes to Assign to the Policy.
  * upgrade_strategy - Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.
    - None - Unspecified upgrade strategy.
    - NoAction - This choice enables No upgrades to be performed.
    - UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.
    - ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.
    - AlwaysReinstall - Always remove older release and reinstall.
  EOT
  type = map(object(
    {
      description       = optional(string)
      install_strategy  = optional(string)
      organization      = optional(string)
      release_name      = optional(string)
      release_namespace = optional(string)
      tags              = optional(list(map(string)))
      upgrade_strategy  = optional(string)
    }
  ))
}


#_____________________________________________________
#
# Configure Add-Ons Policy for the Kubernetes Cluster
#_____________________________________________________

module "addons_policies" {
  source           = "terraform-cisco-modules/imm/intersight//modules/addons_policies"
  for_each         = local.addons_policies
  addon            = each.key
  description      = each.value.description != "" ? each.value.description : "Kubernetes Add-ons Policy for ${each.key}."
  install_strategy = each.value.install_strategy
  name             = each.key
  org_moid         = local.org_moids[each.value.organization].moid
  release_name     = each.value.release_name
  upgrade_strategy = each.value.upgrade_strategy
  tags             = each.value.tags != [] ? each.value.tags : local.tags
}


