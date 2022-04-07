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
  default     = "1.0.3"
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

variable "secretkey" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}


#_______________________________________________
#
# Virtual Machine Infra Config Policy Variables
#_______________________________________________

variable "docker_http_proxy_password" {
  default     = ""
  description = "Password for the Docker HTTP Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "docker_https_proxy_password" {
  default     = ""
  description = "Password for the Docker HTTPS Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "vsphere_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_1" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 1."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_2" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_3" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_4" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}

variable "ssh_public_key_5" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Clusters that use different keys for different clusters."
  sensitive   = true
  type        = string
}
