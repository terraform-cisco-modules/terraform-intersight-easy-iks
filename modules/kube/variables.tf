#__________________________________________________________
#
# Terraform Cloud Organization
#__________________________________________________________

variable "tfc_organization" {
  default     = "CiscoDevNet"
  description = "Terraform Cloud Organization."
  type        = string
}

#______________________________________________
#
# Terraform Cloud global_vars Workspace
#______________________________________________

variable "ws_global_vars" {
  default     = ""
  description = "Global Variables Workspace Name.  The default value will be set to {prefix_value}_global_vars by the tfe variable module."
  type        = string
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

#__________________________________________________________
#
# Cluster Variables
#__________________________________________________________

variable "cluster_name" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster Name.    The default value will be set to {prefix_value}_{cluster_name} by the tfe variable module."
  type        = string
}
