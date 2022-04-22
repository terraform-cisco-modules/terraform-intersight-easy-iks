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
      backend        = "remote"
      kubeconfig_dir = "../kubeconfigs/"
      organization   = "default"
      workspace      = "kubeconfigs"
    }
  ]
  description = <<-EOT
  * backend: Options are:
    - local - The backend is on the Local Machine
    - Remote - The backend is in TFCB.
  * kubeconfig_dir: Name of the Policies directory when the backend is local.
  * organization: Name of the Terraform Cloud Organization when backend is remote.
  * workspace: Name of the workspace in Terraform Cloud.
  EOT
  type = list(object(
    {
      backend        = string
      kubeconfig_dir = optional(string)
      organization   = optional(string)
      workspace      = optional(string)
    }
  ))
}

variable "cluster_name" {
  description = "Name of the Cluster to push Policy to"
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
