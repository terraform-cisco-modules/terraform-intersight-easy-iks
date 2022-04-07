terraform {
  experiments = [module_variable_optional_attrs]
}

#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

variable "tfc_workspaces" {
  default = [
    {
      backend      = "remote"
      organization = "default"
      policies_dir = "../kubernetes_policies/"
      workspace    = "kubernetes_policies"
    }
  ]
  description = <<-EOT
  * backend: Options are:
    - local - The backend is on the Local Machine
    - Remote - The backend is in TFCB.
  * organization: Name of the Terraform Cloud Organization when backend is remote.
  * policies_dir: Name of the Policies directory when the backend is local.
  * workspace: Name of the workspace in Terraform Cloud.
  EOT
  type = list(object(
    {
      backend      = string
      organization = optional(string)
      policies_dir = optional(string)
      workspace    = optional(string)
    }
  ))
}


#__________________________________________________________
#
# Intersight Provider Variables
#__________________________________________________________

variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "secretkey" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}


