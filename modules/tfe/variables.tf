terraform {
  experiments = [module_variable_optional_attrs]
}

#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

variable "agent_pools" {
  default     = []
  description = "Terraform Cloud Agent Pool List."
  type        = list(string)
}

variable "terraform_cloud_token" {
  description = "Token to Authenticate to the Terraform Cloud."
  sensitive   = true
  type        = string
}

variable "oauth_token_id" {
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

variable "target_password" {
  description = "Target Password.  Note: this is the password of the Credentials used to register the Virtualization Target."
  sensitive   = true
  type        = string
}

variable "ssh_public_key" {
  default     = ""
  description = "Intersight Kubernetes Service Cluster SSH Public Key."
  sensitive   = true
  type        = string
}
