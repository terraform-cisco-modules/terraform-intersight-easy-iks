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
# Terraform Cloud kubeconfig Workspace
#______________________________________________

variable "tfc_workspace" {
  default     = ""
  description = "Terraform Cloud Workspace Name."
  type        = string
}

#______________________________________________
#
# Helm Chart Variables
#______________________________________________

variable "helm_chart" {
  description = <<-EOT
  Key - Name of the Helm Chart
  * chart - location to find the chart
  * namespace - Kubernetes Namespace to assign to the pod
  * set - List of Parameters for deployment
  EOT
  type = map(object(
    {
      chart     = string
      namespace = string
      set       = list(map(string))
    }
  ))
}

variable "kubectl_manifest" {
  type = map(object(
    {
      yaml_body = string
    }
  ))
}
