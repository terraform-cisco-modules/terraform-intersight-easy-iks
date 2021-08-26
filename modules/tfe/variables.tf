terraform {
  experiments = [module_variable_optional_attrs]
}

#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

variable "agent_pool" {
  description = "Terraform Cloud Agent Pool."
  type        = string
}

variable "terraform_cloud_token" {
  description = "Token to Authenticate to the Terraform Cloud."
  sensitive   = true
  type        = string
}

variable "tfc_oauth_token" {
  description = "Terraform Cloud OAuth Token for VCS_Repo Integration."
  sensitive   = true
  type        = string
}

variable "tfc_organization" {
  description = "Terraform Cloud Organization Name."
  type        = string
}

variable "terraform_version" {
  default     = "1.0.0"
  description = "Terraform Target Version."
  type        = string
}

variable "vcs_repo" {
  description = "Version Control System Repository."
  type        = string
}


#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}


#__________________________________________________________
#
# Global Variables
#__________________________________________________________

variable "organizations" {
  default     = ["default"]
  description = "Intersight Organization Names to Apply Policy to.  https://intersight.com/an/settings/organizations/."
  type        = set(string)
}

variable "tags" {
  default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = list(map(string))
}


#__________________________________________________________
#
# Workspace Variables
#__________________________________________________________

variable "workspaces" {
  default = {
    default = {
      auto_apply        = true
      cluster_name      = ""
      create_app_hello  = false
      create_iwo        = false
      description       = ""
      working_directory = "modules/k8s_policies"
      workspace_type    = "k8s_policies"
    }
  }
  description = <<-EOT
  Map of Workspaces to create in Terraform Cloud.
  key - Name of the Workspace to Create.
  * auto_apply - Terraform Apply occur without a confirmation; after a successful plan.
  * cluster_name - Use this variable for the IKS Cluster Workspace if the Workspace Name != Cluster Name.
  * create_app_hello - Use this variable to tell the script to create the app_hello workspace or not.
  * create_iwo - Use this variable to tell the script to create the iwo workspace or not.
  * description - A Description for the Workspace.
  * working_directory - The Directory of the Version Control Repository that contains the Terraform code for UCS Domain Profiles for this Workspace.
  * workspace_type - What Type of Workspace will this Create.  Options are:
    - iks
    - k8s_policies
  EOT
  type = map(object(
    {
      auto_apply        = optional(bool)
      cluster_name      = optional(string)
      create_app_hello  = optional(bool)
      create_iwo        = optional(bool)
      description       = optional(string)
      working_directory = optional(string)
      workspace_type    = optional(string)
    }
  ))
}
