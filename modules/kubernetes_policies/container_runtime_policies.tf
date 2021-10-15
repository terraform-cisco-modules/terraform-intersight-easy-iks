#______________________________________________
#
# Container Runtime Policy Variables
#______________________________________________

variable "container_runtime_policies" {
  default = {
    default = { # The Addon Policy Name will be {each.key}.  In this case it would be default if left like this.
      description             = ""
      docker_daemon_bridge_ip = ""
      docker_no_proxy         = []
      http_hostname           = ""
      http_port               = 8080
      http_protocol           = "http"
      http_username           = ""
      https_hostname          = ""
      https_port              = 8443
      https_protocol          = "https"
      https_username          = ""
      organization            = "default"
      tags                    = []
    }
  }
  description = <<-EOT
  Intersight Container Runtime Policy Variable Map.
  Key - Name of the Container Runtime Policy.
  * description - A description for the policy.
  * docker_daemon_bridge_ip - Bridge IP (--bip) including Prefix (e.g., 172.17.0.5/24) that Docker will use for the default bridge network (docker0). Containers will connect to this if no other network is configured, not used by kubernetes pods because their network is managed by CNI. However this address space must not collide with other CIDRs on your networks, including the cluster's Service CIDR, Pod Network CIDR and IP Pools.
  * docker_no_proxy - Used to optionally exclude hosts or ranges from going through the proxy server.
    Refer to https://docs.docker.com/network/proxy/ for details.
  * http_hostname - HTTP/HTTPS Proxy server FQDN or IP.
  * http_port - The HTTP Proxy port number. The port number of the HTTP/HTTPS proxy must be between 1 and 65535, inclusive.
  * http_protocol - Protocol to use for the HTTP/HTTPS Proxy.
    - http
    - https
  * http_username - The username for the HTTP/HTTPS Proxy.
  * https_hostname - HTTP/HTTPS Proxy server FQDN or IP.
  * https_port - The HTTPS Proxy port number. The port number of the HTTP/HTTPS proxy must be between 1 and 65535, inclusive.
  * https_protocol - Protocol to use for the HTTP/HTTPS Proxy.
    - http
    - https
  * https_username - The username for the HTTP/HTTPS Proxy.
  * organization - Name of the Intersight Organization to assign this pool to.
    - https://intersight.com/an/settings/organizations/
  * tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      description             = optional(string)
      docker_daemon_bridge_ip = optional(string)
      docker_no_proxy         = optional(list(string))
      http_hostname           = optional(string)
      http_port               = optional(number)
      http_protocol           = optional(string)
      http_username           = optional(string)
      https_hostname          = optional(string)
      https_port              = optional(number)
      https_protocol          = optional(string)
      https_username          = optional(string)
      organization            = optional(string)
      tags                    = optional(list(map(string)))
    }
  ))
}

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
  source                  = "terraform-cisco-modules/imm/intersight//modules/container_runtime_policies"
  for_each                = local.container_runtime_policies
  description             = each.value.description != "" ? each.value.description : "${each.key} Runtime Policy."
  docker_daemon_bridge_ip = each.value.docker_daemon_bridge_ip
  docker_no_proxy         = each.value.docker_no_proxy
  org_moid                = local.org_moids[each.value.organization].moid
  name                    = each.key
  proxy_http_hostname     = each.value.http_hostname
  proxy_http_port         = each.value.http_port
  proxy_http_password     = var.container_runtime_http_password
  proxy_http_protocol     = each.value.http_protocol
  proxy_http_username     = each.value.http_username
  proxy_https_hostname    = each.value.https_hostname != "" ? each.value.https_hostname : each.value.http_hostname
  proxy_https_password    = var.container_runtime_https_password
  proxy_https_port        = each.value.https_port
  proxy_https_protocol    = each.value.https_protocol
  proxy_https_username    = each.value.https_username != "" ? each.value.https_username : each.value.http_username
  tags                    = each.value.tags != [] ? each.value.tags : local.tags
}
