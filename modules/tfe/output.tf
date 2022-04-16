#__________________________________________________________
#
# Output Agent Pool ID from Terraform Cloud
#__________________________________________________________

output "tfc_agent_pool" {
  description = "Terraform Cloud Agent Pool ID."
  value = {
    for k in sort(keys(data.tfe_agent_pool.agent_pools)) : k => data.tfe_agent_pool.agent_pools[k]
  }
}

output "workspaces" {
  description = "Terraform Cloud Workspace IDs and Names."
  value = { for k in sort(keys(tfe_workspace.workspaces)) : k => {
    name = tfe_workspace.workspaces[k].name
    id   = tfe_workspace.workspaces[k].id
    }
  }
}

