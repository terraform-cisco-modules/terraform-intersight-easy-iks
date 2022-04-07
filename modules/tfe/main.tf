#__________________________________________________________
#
# Obtain Agent Pool ID from Terraform Cloud
#__________________________________________________________

module "tfc_agent_pool" {
  source       = "terraform-cisco-modules/modules/tfe//modules/tfc_agent_pool"
  version      = "0.6.2"
  agent_pool   = var.agent_pool
  tfc_org_name = var.tfc_organization
}

#__________________________________________________________
#
# Terraform Cloud Workspaces Module
#__________________________________________________________

variable "workspaces" {
  default = {
    default = {
      agent_pool                = ""
      allow_destroy_plan        = true
      auto_apply                = false
      branch                    = "master"
      description               = ""
      global_remote_state       = false
      queue_all_runs            = false
      remote_state_consumer_ids = []
      speculative_enabled       = true
      working_directory         = ""
      workspace_type            = ""
    }
  }
  description = <<-EOT
  Map of Workspaces to create in Terraform Cloud.
  key - Name of the Workspace to Create.
  * agent_pool - Name of the Agent Pool to Assign to the Workspace
  * allow_destroy_plan - Default is true.
  * auto_apply - Defualt is false.  Automatically apply changes when a Terraform plan is successful. Plans that have no changes will not be applied. If this workspace is linked to version control, a push to the default branch of the linked repository will trigger a plan and apply.
  * branch - Default is "master".  The repository branch that Terraform will execute from. Default to master.
  * description - A Description for the Workspace.
  * global_remote_state - Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state (remote_state_consumer_ids)..
  * queue_all_runs - needs description.
  * remote_state_consumer_ids - The set of workspace IDs set as explicit remote state consumers for the given workspace.
  * working_directory - The Directory of the Version Control Repository that contains the Terraform code for UCS Domain Profiles for this Workspace.
  * workspace_type - What Type of Workspace will this Create.  Options are:
    - app
    - cluster
    - policies
    - kubeconfig
  EOT
  type = map(object(
    {
      agent_pool                = optional(string)
      allow_destroy_plan        = optional(bool)
      auto_apply                = optional(bool)
      branch                    = optional(string)
      description               = optional(string)
      execution_mode            = optional(string)
      global_remote_state       = optional(bool)
      queue_all_runs            = optional(bool)
      remote_state_consumer_ids = optional(list(string))
      speculative_enabled       = optional(bool)
      working_directory         = string
      workspace_type            = string
    }
  ))
}


#__________________________________________________________
#
# Terraform Cloud Workspaces Module
#__________________________________________________________

module "workspaces" {
  depends_on = [
    module.tfc_agent_pool
  ]
  source                    = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  version                   = "0.6.2"
  for_each                  = local.workspaces
  agent_pool                = each.value.execution_mode == "agent" ? module.tfc_agent_pool.tfc_agent_pool : ""
  allow_destroy_plan        = each.value.allow_destroy_plan
  auto_apply                = each.value.auto_apply
  branch                    = each.value.branch
  description               = each.value.description
  execution_mode            = each.value.execution_mode
  global_remote_state       = each.value.global_remote_state
  name                      = each.key
  queue_all_runs            = each.value.queue_all_runs
  remote_state_consumer_ids = each.value.remote_state_consumer_ids
  speculative_enabled       = each.value.speculative_enabled
  terraform_version         = var.terraform_version
  tfc_oauth_token           = var.tfc_oauth_token
  tfc_org_name              = var.tfc_organization
  vcs_repo                  = var.vcs_repo
  working_directory         = each.value.working_directory
}

output "workspaces" {
  description = "Terraform Cloud Workspace IDs and Names."
  value       = { for v in sort(keys(module.workspaces)) : v => module.workspaces[v] }
}

#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

module "intersight_variables" {
  source  = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  version = "0.6.2"
  depends_on = [
    module.workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if length(regexall("(cluster|policies|kubeconfig)", local.workspaces[k].workspace_type)) > 0
  }
  category     = "terraform"
  workspace_id = module.workspaces[each.key].workspace.id
  variable_list = {
    apikey = {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    }
  }
}

#__________________________________________________________
#
# Kubernetes Policies Variables
#__________________________________________________________

module "kubernetes_policies_variables" {
  source  = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  version = "0.6.2"
  depends_on = [
    module.workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if length(regexall("policies", local.workspaces[k].workspace_type)) > 0
  }
  category     = "terraform"
  workspace_id = module.workspaces[each.key].workspace.id
  variable_list = {
    "docker_http_proxy_password" = {
      description = "Container Runtime HTTP Proxy Password."
      key         = "docker_http_proxy_password"
      sensitive   = true
      value       = var.docker_http_proxy_password
    }
    "docker_https_proxy_password" = {
      description = "Container Runtime HTTPS Proxy Password."
      key         = "docker_https_proxy_password"
      sensitive   = true
      value       = var.docker_https_proxy_password
    }
    "vsphere_password" = {
      description = "Virtual Center Password."
      key         = "vsphere_password"
      sensitive   = true
      value       = var.vsphere_password
    }
  }
}

#__________________________________________________________
#
# Kubernetes Cluster Profiles Variables
#__________________________________________________________

module "kubernetes_cluster_profiles_variables" {
  source  = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  version = "0.6.2"
  depends_on = [
    module.workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if length(regexall("cluster", local.workspaces[k].workspace_type)) > 0
  }
  category     = "terraform"
  workspace_id = module.workspaces[each.key].workspace.id
  variable_list = {
    #---------------------------
    # IKS Cluster Variables
    #---------------------------
    ssh_public_key_1 = {
      description = "SSH Public Key Variable 1."
      key         = "ssh_public_key_1"
      sensitive   = true
      value       = var.ssh_public_key_1
    },
    ssh_public_key_2 = {
      description = "SSH Public Key Variable 2."
      key         = "ssh_public_key_2"
      sensitive   = true
      value       = var.ssh_public_key_2
    },
    ssh_public_key_3 = {
      description = "SSH Public Key Variable 3."
      key         = "ssh_public_key_3"
      sensitive   = true
      value       = var.ssh_public_key_3
    },
    ssh_public_key_4 = {
      description = "SSH Public Key Variable 4."
      key         = "ssh_public_key_4"
      sensitive   = true
      value       = var.ssh_public_key_4
    },
    ssh_public_key_5 = {
      description = "SSH Public Key Variable 5."
      key         = "ssh_public_key_5"
      sensitive   = true
      value       = var.ssh_public_key_5
    },
  }
}
