# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}

data "intersight_ippool_pool" "ip_pool" {
  name = var.name
}
