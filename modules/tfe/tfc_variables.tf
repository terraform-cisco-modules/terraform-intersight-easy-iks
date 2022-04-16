#__________________________________________________________
#
# Terraform Cloud Workspace Variables
#__________________________________________________________

variable "variable_list" {
  default = [
    {
      category    = "terraform"
      description = ""
      key         = "**REQUIRED**"
      sensitive   = true
      value       = ""
      var_type    = "**REQUIRED**"
    }
  ]
  description = <<-EOT
  * key - (Required) Name of the variable.
  * value - (Required) Value of the variable.
  * category - (Required) Whether this is a Terraform or environment variable. Valid values are terraform or env.
  * description - (Optional) Description of the variable.
  * hcl - (Optional) Whether to evaluate the value of the variable as a string of HCL code. Has no effect for environment variables. Defaults to false.
  * sensitive - (Optional) Whether the value is sensitive. If true then the variable is written once and not visible thereafter. Defaults to false.
  * value - (Optional) The Value to assign to the variable.
  * var_type:
    - cluster: Kubernetes Cluster Variables
    - intersight: Intersight Variables
    - policies: Kubernetes Policy Variables
  EOT
  type = list(object(
    {
      category    = optional(string)
      description = optional(string)
      key         = string
      sensitive   = optional(bool)
      value       = optional(string)
      var_type    = string
    }
  ))

}

resource "tfe_variable" "intersight_variables" {
  depends_on = [
    tfe_workspace.workspaces
  ]
  for_each    = local.intersight_variables
  category    = each.value.category
  description = each.value.description
  key         = each.value.key
  sensitive   = each.value.sensitive
  value = length(regexall(
    "apikey", each.value.key)) > 0 ? var.apikey : length(regexall(
  "secretkey", each.value.key)) > 0 ? var.secretkey : each.value.value
  workspace_id = tfe_workspace.workspaces[each.value.workspace].id
}
resource "tfe_variable" "policies_variables" {
  depends_on = [
    tfe_workspace.workspaces
  ]
  for_each    = local.policies_variables
  category    = each.value.category
  description = each.value.description
  key         = each.value.key
  sensitive   = each.value.sensitive
  value = length(regexall(
    "target_password", each.value.key)) > 0 ? var.target_password : length(regexall(
    "docker_http_proxy_password", each.value.key)
    ) > 0 ? var.docker_http_proxy_password : length(regexall(
    "docker_https_proxy_password", each.value.key)
  ) > 0 ? var.docker_https_proxy_password : each.value.value
  workspace_id = tfe_workspace.workspaces[each.value.workspace].id
}
resource "tfe_variable" "cluster_variables" {
  depends_on = [
    tfe_workspace.workspaces
  ]
  for_each    = local.cluster_variables
  category    = each.value.category
  description = each.value.description
  key         = each.value.key
  sensitive   = each.value.sensitive
  value = length(regexall(
    "ssh_public_key_1", each.value.key)
  ) > 0 ? var.ssh_public_key_1 : each.value.value
  workspace_id = tfe_workspace.workspaces[each.value.workspace].id
}
