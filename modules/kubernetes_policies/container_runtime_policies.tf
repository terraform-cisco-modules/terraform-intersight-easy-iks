#______________________________________________
#
# Container Runtime Policy Variables
#______________________________________________

# Terraform Cloud JSON Parse Mode
variable "container_runtime_policies" {
  description = "Please Refer to OSS Model Below for Variable Details"
  type        = string
}

# Terraform OSS Mode
# variable "container_runtime_policies" {
#   default = {
#     default = { # The Addon Policy Name will be {each.key}.  In this case it would be default if left like this.
#       description        = ""
#       docker_bridge_cidr = ""
#       docker_no_proxy    = []
#       http_hostname      = ""
#       http_port          = 8080
#       http_protocol      = "http"
#       http_username      = ""
#       https_hostname     = ""
#       https_port         = 8443
#       https_protocol     = "https"
#       https_username     = ""
#       organization       = "default"
#       tags               = []
#     }
#   }
#   description = <<-EOT
#   Intersight Container Runtime Policy Variable Map.
#   Key - Name of the Container Runtime Policy.
#   * description - A description for the policy.
#   * docker_bridge_cidr - The CIDR for docker bridge network. This address space must not collide
#     with other CIDRs on your networks, including the cluster's service CIDR, pod CIDR and IP Pools.
#   * docker_no_proxy - Docker no proxy list, when using internet proxy.
#   * http_hostname - Hostname of the HTTP Proxy Server.
#   * http_port - HTTP Proxy Port.  Range is 1-65535.
#   * http_protocol - HTTP Proxy Protocol. Options are {http|https}.
#   * http_username - Username for the HTTP Proxy Server.
#   * https_hostname - Hostname of the HTTPS Proxy Server.
#   * https_port - HTTPS Proxy Port.  Range is 1-65535
#   * https_protocol - HTTPS Proxy Protocol. Options are {http|https}.
#   * https_username - Username for the HTTPS Proxy Server.
#   * organization - Name of the Intersight Organization to assign this pool to.
#     - https://intersight.com/an/settings/organizations/
#   * tags - List of key/value Attributes to Assign to the Policy.
#   EOT
#   type = map(object(
#     {
#       description        = optional(string)
#       docker_bridge_cidr = optional(string)
#       docker_no_proxy    = optional(list(string))
#       http_hostname      = optional(string)
#       http_port          = optional(number)
#       http_protocol      = optional(string)
#       http_username      = optional(string)
#       https_hostname     = optional(string)
#       https_port         = optional(number)
#       https_protocol     = optional(string)
#       https_username     = optional(string)
#       organization       = optional(string)
#       tags               = optional(list(map(string)))
#     }
#   ))
# }

variable "container_runtime_http_password" {
  default     = ""
  description = "Password for the HTTP Proxy Server, If required."
  sensitive   = true
  type        = string
}

variable "container_runtime_https_password" {
  default     = ""
  description = "Password for the HTTPS Proxy Server, If required."
  sensitive   = true
  type        = string
}

#______________________________________________
#
# Kubernetes Runtime Policy Module
#______________________________________________

module "container_runtime_policies" {
  source               = "terraform-cisco-modules/imm/intersight//modules/container_runtime_policies"
  for_each             = local.container_runtime_policies
  description          = each.value.description != "" ? each.value.description : "${each.key} Runtime Policy."
  docker_bridge_cidr   = each.value.docker_bridge_cidr
  docker_no_proxy      = each.value.docker_no_proxy
  org_moid             = local.org_moids[each.value.organization].moid
  name                 = each.key
  proxy_http_hostname  = each.value.http_hostname
  proxy_http_port      = each.value.http_port
  proxy_http_password  = var.container_runtime_http_password
  proxy_http_protocol  = each.value.http_protocol
  proxy_http_username  = each.value.http_username
  proxy_https_hostname = each.value.https_hostname != "" ? each.value.https_hostname : each.value.http_hostname
  proxy_https_password = var.container_runtime_https_password
  proxy_https_port     = each.value.https_port
  proxy_https_protocol = each.value.https_protocol
  proxy_https_username = each.value.https_username != "" ? each.value.https_username : each.value.http_username
  tags                 = each.value.tags != [] ? each.value.tags : local.tags
}
