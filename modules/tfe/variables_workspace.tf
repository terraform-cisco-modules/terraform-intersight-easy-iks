variable "workspaces" {
  default = {
    default = {
      auto_apply        = true
      description       = ""
      working_directory = "modules/k8s_policies"
      workspace_type    = "k8s_policies"
      ws_kubeconfig     = ""
    }
  }
  description = <<-EOT
  Map of Workspaces to create in Terraform Cloud.
  key - Name of the Workspace to Create.
  * description - A Description for the Workspace.
  * working_directory - The Directory of the Version Control Repository that contains the Terraform code for UCS Domain Profiles for this Workspace.
  * workspace_type - What Type of Workspace will this Create.  Options are:
    - app
    - iks
    - k8s_policies
    - kubeconfig
  * ws_kubeconfig - This variable is only required for the workspace_type of app.
  EOT
  type = map(object(
    {
      auto_apply        = optional(bool)
      description       = optional(string)
      working_directory = optional(string)
      workspace_type    = optional(string)
      ws_kubeconfig     = optional(string)
    }
  ))
}
