#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: User Drop Down > Account {Name} > Account ID
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  name = var.organization
}

data "intersight_ippool_pool" "ip_pools" {
  depends_on = [
    data.intersight_organization_organization.org_moid
  ]
  for_each = { for k, v in local.ip_pools : k => v if v.create_pool == false }
  name     = each.key
  organization {
    moid = data.intersight_organization_organization.org_moid.results[0].moid
  }
}