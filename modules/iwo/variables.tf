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
# Terraform Cloud kube Workspace
#______________________________________________

variable "ws_kube" {
  default     = ""
  description = "Intersight Kubernetes Service (IKS) kube_config Workspace Name.  The default value will be set to {prefix_value}_{cluster_name}_kube by the tfe variable module."
  type        = string
}
