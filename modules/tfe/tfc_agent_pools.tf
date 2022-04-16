#__________________________________________________________
#
# Obtain Agent Pool ID from Terraform Cloud
#__________________________________________________________

data "tfe_agent_pool" "agent_pools" {
  for_each     = toset(var.agent_pools)
  name         = each.value
  organization = var.tfc_organization
}
