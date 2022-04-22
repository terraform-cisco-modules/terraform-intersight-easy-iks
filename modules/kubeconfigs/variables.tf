#__________________________________________________________
#
# Intersight Provider Variables
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
# Intersight Kubernetes Service Cluster Name
#__________________________________________________________

variable "cluster_names" {
  description = "Intersight Kubernetes Service Cluster Name"
  type        = list(string)
}

