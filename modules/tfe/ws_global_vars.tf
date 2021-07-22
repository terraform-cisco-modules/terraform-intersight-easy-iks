#__________________________________________________________
#
# Required Variables
#__________________________________________________________

variable "prefix_value" {
  default     = "default"
  description = "Prefix Value for Workspace Creation in Terraform Cloud and IKS Cluster Naming."
  type        = string
}


#______________________________________________
#
# DNS Variables
#______________________________________________

variable "domain_name" {
  default     = "demo.intra"
  description = "Domain Name for Kubernetes Sysconfig Policy."
  type        = string
}

variable "dns_servers" {
  default     = ["10.200.0.100"]
  description = "DNS Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}

#______________________________________________
#
# Time Variables
#______________________________________________

variable "ntp_servers" {
  default     = []
  description = "NTP Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}

variable "timezone" {
  default     = "Etc/GMT"
  description = "Timezone for Deployment.  For a List of supported timezones see the following URL.\r\n https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md."
  type        = string
}


#__________________________________________________________
#
# Terraform Cloud Workspace: {name_prefix}_global_vars
#__________________________________________________________

module "global_workspace" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  depends_on = [
    module.tfc_agent_pool
  ]
  auto_apply          = true
  description         = "${var.name_prefix}_global_vars Workspace."
  global_remote_state = true
  name                = "${var.name_prefix}_global_vars"
  terraform_version   = var.terraform_version
  tfc_oath_token      = var.tfc_oath_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "global_vars"
}

output "global_workspace" {
  description = "Terraform Cloud Workspace global_vars ID."
  value       = module.global_workspace
}

#__________________________________________________________
#
# Terraform Cloud Workspace Variables: global_vars
#__________________________________________________________

module "tfc_variables_global" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.global_workspace
  ]
  category     = "terraform"
  for_each     = var.cluster_list
  workspace_id = module.global_workspace.workspace.id
  variable_list = [
    {
      description = "Intersight Organization."
      key         = "organization"
      value       = var.organization
    },
    {
      description = "Domain Name."
      key         = "domain_name"
      value       = var.domain_name
    },
    {
      description = "DNS Servers."
      key         = "dns_servers"
      value       = "${var.dns_servers}"
    },
    {
      description = "NTP Servers."
      hcl         = true
      key         = "ntp_servers"
      value       = "${var.ntp_servers}"
    },
  ]
}
