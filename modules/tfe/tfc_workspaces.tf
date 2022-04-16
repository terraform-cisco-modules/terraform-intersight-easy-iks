#__________________________________________________________
#
# Terraform Cloud Workspaces Module
#__________________________________________________________

variable "workspaces" {
  default = {
    default = {
      agent_pool                    = ""
      allow_destroy_plan            = true
      auto_apply                    = false
      description                   = ""
      execution_mode                = "remote"
      file_triggers_enabled         = true
      global_remote_state           = false
      queue_all_runs                = false
      remote_state_consumer_ids     = []
      speculative_enabled           = true
      ssh_key_id                    = ""
      structured_run_output_enabled = true
      tag_names                     = []
      terraform_version             = "1.1.8"
      trigger_prefixes              = []
      working_directory             = ""
      workspace_type                = "**REQUIRED**"
      vcs_repo = [
        {
          branch             = ""
          identifier         = "**REQUIRED**"
          ingress_submodules = false
        }
      ]
    }
  }
  description = <<-EOT
  * agent_pool - (Optional) The Name of an agent pool to assign to the workspace. Requires execution_mode to be set to agent. This value must not be provided if execution_mode is set to any other value or if operations is provided.
  * allow_destroy_plan - (Optional) Whether destroy plans can be queued on the workspace.
  * auto_apply - (Optional) Whether to automatically apply changes when a Terraform plan is successful. Defaults to false.
  * description - (Optional) A description for the workspace.
  * execution_mode - (Optional) Which execution mode to use. Using Terraform Cloud, valid values are remote, local oragent. Defaults to remote. Using Terraform Enterprise, only remoteand local execution modes are valid. When set to local, the workspace will be used for state storage only. This value must not be provided if operations is provided.
  * file_triggers_enabled - (Optional) Whether to filter runs based on the changed files in a VCS push. Defaults to true. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run.
  * global_remote_state - (Optional) Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state (remote_state_consumer_ids).
  * remote_state_consumer_ids - (Optional) The set of workspace IDs set as explicit remote state consumers for the given workspace.
  * queue_all_runs - (Optional) Whether the workspace should start automatically performing runs immediately after its creation. Defaults to true. When set to false, runs triggered by a webhook (such as a commit in VCS) will not be queued until at least one run has been manually queued. Note: This default differs from the Terraform Cloud API default, which is false. The provider uses true as any workspace provisioned with false would need to then have a run manually queued out-of-band before accepting webhooks.
  * speculative_enabled - (Optional) Whether this workspace allows speculative plans. Defaults to true. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors.
  * ssh_key_id - (Optional) The ID of an SSH key to assign to the workspace.
  * structured_run_output_enabled - (Optional) Whether this workspace should show output from Terraform runs using the enhanced UI when available. Defaults to true. Setting this to false ensures that all runs in this workspace will display their output as text logs.
  * tag_names - (Optional) A list of tag names for this workspace. Note that tags must only contain letters, numbers or colons.
  * terraform_version - (Optional) The version of Terraform to use for this workspace. This can be either an exact version or a version constraint (like ~> 1.0.0); if you specify a constraint, the workspace will always use the newest release that meets that constraint. Defaults to the latest available version.
  * trigger_prefixes - (Optional) List of repository-root-relative paths which describe all locations to be tracked for changes.
  * working_directory - (Optional) A relative path that Terraform will execute within. Defaults to the root of your repository.
  * workspace_type - What Type of Workspace will this Create.  Options are:
    - app
    - cluster
    - policies
    - kubeconfig
  * vcs_repo - (Optional) Settings for the workspace's VCS repository, enabling the UI/VCS-driven run workflow. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider.
  * The vcs_repo block supports:
    - branch - (Optional) The repository branch that Terraform will execute from. This defaults to the repository's default branch (e.g. main).
    - identifier - (Required) A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is //_git/.
    - ingress_submodules - (Optional) Whether submodules should be fetched when cloning the VCS repository. Defaults to false.
  EOT
  type = map(object(
    {
      agent_pool                    = optional(string)
      allow_destroy_plan            = optional(bool)
      auto_apply                    = optional(bool)
      description                   = optional(string)
      execution_mode                = optional(string)
      file_triggers_enabled         = optional(bool)
      global_remote_state           = optional(bool)
      queue_all_runs                = optional(bool)
      remote_state_consumer_ids     = optional(list(string))
      speculative_enabled           = optional(bool)
      ssh_key_id                    = optional(string)
      structured_run_output_enabled = optional(bool)
      tag_names                     = optional(list(string))
      terraform_version             = optional(string)
      trigger_prefixes              = optional(list(string))
      working_directory             = string
      workspace_type                = string
      vcs_repo = optional(list(object(
        {
          branch             = optional(string)
          identifier         = optional(string)
          ingress_submodules = optional(bool)
        }
      )))
    }
  ))
}

resource "tfe_workspace" "workspaces" {
  depends_on = [
    data.tfe_agent_pool.agent_pools
  ]
  for_each = local.workspaces
  agent_pool_id = length(
    compact([each.value.agent_pool])
  ) > 0 ? data.tfe_agent_pool.agent_pools[each.value.agent_pool].id : ""
  allow_destroy_plan            = each.value.allow_destroy_plan
  auto_apply                    = each.value.auto_apply
  description                   = each.value.description != ""
  execution_mode                = each.value.execution_mode
  file_triggers_enabled         = each.value.file_triggers_enabled
  global_remote_state           = each.value.global_remote_state
  name                          = each.key
  organization                  = var.tfc_organization
  queue_all_runs                = each.value.queue_all_runs
  remote_state_consumer_ids     = each.value.remote_state_consumer_ids
  speculative_enabled           = each.value.speculative_enabled
  structured_run_output_enabled = each.value.structured_run_output_enabled
  tag_names                     = each.value.tag_names
  terraform_version             = each.value.terraform_version
  trigger_prefixes              = each.value.trigger_prefixes
  working_directory             = each.value.working_directory
  dynamic "vcs_repo" {
    for_each = each.value.vcs_repo
    content {
      branch             = vcs_repo.value.branch
      identifier         = vcs_repo.value.identifier
      ingress_submodules = vcs_repo.value.ingress_submodules
      oauth_token_id     = var.oauth_token_id
    }
  }
}
