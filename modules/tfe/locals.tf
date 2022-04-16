locals {
  workspaces = {
    for k, v in var.workspaces : k => {
      agent_pool                    = v.agent_pool != null ? v.agent_pool : ""
      allow_destroy_plan            = v.allow_destroy_plan != null ? v.allow_destroy_plan : true
      auto_apply                    = v.auto_apply != null ? v.auto_apply : false
      description                   = v.description != null ? v.description : ""
      execution_mode                = v.execution_mode != null ? v.execution_mode : "remote"
      file_triggers_enabled         = v.file_triggers_enabled != null ? v.file_triggers_enabled : true
      global_remote_state           = v.global_remote_state != null ? v.global_remote_state : false
      queue_all_runs                = v.queue_all_runs != null ? v.queue_all_runs : false
      remote_state_consumer_ids     = v.remote_state_consumer_ids != null ? v.remote_state_consumer_ids : []
      speculative_enabled           = v.speculative_enabled != null ? v.speculative_enabled : true
      ssh_key_id                    = v.ssh_key_id != null ? v.ssh_key_id : ""
      structured_run_output_enabled = v.structured_run_output_enabled != null ? v.structured_run_output_enabled : true
      tag_names                     = v.tag_names != null ? v.tag_names : []
      terraform_version             = v.terraform_version != null ? v.terraform_version : "1.1.8"
      trigger_prefixes              = v.trigger_prefixes != null ? v.trigger_prefixes : []
      working_directory             = v.working_directory != null ? v.working_directory : ""
      workspace_type                = v.workspace_type != null ? v.workspace_type : ""
      vcs_repo = v.vcs_repo != null ? [
        for key, value in v.vcs_repo : {
          branch             = value.branch != null ? value.branch : ""
          identifier         = value.identifier != null ? value.identifier : var.vcs_repo
          ingress_submodules = value.ingress_submodules != null ? value.ingress_submodules : false
        }
        ] : [
        {
          branch             = ""
          identifier         = var.vcs_repo
          ingress_submodules = false
        }
      ]
    }
  }
  variable_list = {
    for k, v in var.variable_list : k => {
      category    = v.category != null ? v.category : "terraform"
      description = v.description != null ? v.description : ""
      key         = v.key
      sensitive   = v.sensitive != null ? v.sensitive : true
      value       = v.value != null ? v.value : ""
      var_type    = v.var_type
    }
  }

  cluster_loop = flatten([
    for k, v in local.variable_list : [
      for key, value in local.workspaces : {
        category       = v.category
        description    = v.description
        key            = v.key
        sensitive      = v.sensitive
        var_type       = v.var_type
        workspace_type = value.workspace_type
        workspace      = key
        } if length(regexall(
        "cluster", value.workspace_type)
      ) > 0 && v.var_type == "cluster"
    ]
  ])

  intersight_loop = flatten([
    for k, v in local.variable_list : [
      for key, value in local.workspaces : {
        category       = v.category
        description    = v.description
        key            = v.key
        sensitive      = v.sensitive
        var_type       = v.var_type
        workspace_type = value.workspace_type
        workspace      = key
        } if length(regexall(
        "(cluster|policies|kubeconfig)", value.workspace_type)
      ) > 0 && v.var_type == "intersight"
    ]
  ])

  policies_loop = flatten([
    for k, v in local.variable_list : [
      for key, value in local.workspaces : {
        category       = v.category
        description    = v.description
        key            = v.key
        sensitive      = v.sensitive
        var_type       = v.var_type
        workspace_type = value.workspace_type
        workspace      = key
        } if length(regexall(
        "(policies)", value.workspace_type)
      ) > 0 && v.var_type == "policies"
    ]
  ])

  cluster_variables    = { for k, v in local.cluster_loop : "${v.workspace}_${v.key}" => v }
  intersight_variables = { for k, v in local.intersight_loop : "${v.workspace}_${v.key}" => v }
  policies_variables   = { for k, v in local.policies_loop : "${v.workspace}_${v.key}" => v }
}
