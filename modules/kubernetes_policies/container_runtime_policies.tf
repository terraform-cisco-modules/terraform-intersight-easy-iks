#______________________________________________
#
# Container Runtime Policy Variables
#______________________________________________

variable "container_runtime_policies" {
  default = {
    default = { # The Addon Policy Name will be {each.key}.  In this case it would be default if left like this.
      description               = ""
      docker_daemon_bridge_cidr = ""
      docker_no_proxy           = []
      docker_http_proxy = [
        {
          hostname = ""
          port     = 8080
          protocol = "http"
          username = ""
        }
      ]
      docker_https_proxy = [
        {
          hostname = ""
          port     = 8443
          protocol = "https"
          username = ""
        }
      ]
      tags = []
    }
  }
  description = <<-EOT
  Intersight Container Runtime Policy Variable Map.
  Key - Name of the Container Runtime Policy.
  * description - A description for the policy.
  * docker_daemon_bridge_ip - Bridge IP (--bip) including Prefix (e.g., 172.17.0.5/24) that Docker will use for the default bridge network (docker0). Containers will connect to this if no other network is configured, not used by kubernetes pods because their network is managed by CNI. However this address space must not collide with other CIDRs on your networks, including the cluster's Service CIDR, Pod Network CIDR and IP Pools.
  * docker_no_proxy - Used to optionally exclude hosts or ranges from going through the proxy server.
    Refer to https://docs.docker.com/network/proxy/ for details.
  * docker_http_proxy
    - hostname - HTTP/HTTPS Proxy server FQDN or IP.
    - port - The HTTP Proxy port number. The port number of the HTTP/HTTPS proxy must be between 1 and 65535, inclusive.
    - protocol - Protocol to use for the HTTP/HTTPS Proxy.
      * http
      * https
    - username - The username for the HTTP/HTTPS Proxy.
  * docker_https_proxy
    - hostname - HTTP/HTTPS Proxy server FQDN or IP.
    - port - The HTTP Proxy port number. The port number of the HTTP/HTTPS proxy must be between 1 and 65535, inclusive.
    - protocol - Protocol to use for the HTTP/HTTPS Proxy.
      * http
      * https
    - username - The username for the HTTP/HTTPS Proxy.
  * tags - List of key/value Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      description               = optional(string)
      docker_daemon_bridge_cidr = optional(string)
      docker_no_proxy           = optional(list(string))
      docker_http_proxy = optional(list(object(
        {
          hostname = string
          port     = optional(number)
          protocol = optional(string)
          username = optional(string)
        }
      )))
      docker_https_proxy = optional(list(object(
        {
          hostname = string
          port     = optional(number)
          protocol = optional(string)
          username = optional(string)
        }
      )))
      tags = optional(list(map(string)))
    }
  ))
}

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

#__________________________________________________________________
#
# Intersight Kubernetes Container Runtime Policy
# GUI Location: Policies > Create Policy > Container Runtime
#__________________________________________________________________

resource "intersight_kubernetes_container_runtime_policy" "container_runtime" {
  for_each                   = local.container_runtime_policies
  description                = each.value.description != "" ? each.value.description : "${each.key} Runtime Policy."
  name                       = each.key
  docker_bridge_network_cidr = each.value.docker_daemon_bridge_cidr
  docker_no_proxy            = each.value.docker_no_proxy
  organization {
    moid        = local.org_moid
    object_type = "organization.Organization"
  }
  dynamic "docker_http_proxy" {
    for_each = { for k, v in each.value.docker_http_proxy : k => v if length(regexall("[a-zA-Z0-9]", v.hostname)) > 0 }
    content {
      hostname = docker_http_proxy.value.hostname
      password = length(regexall("[a-zA-Z]", docker_http_proxy.value.username)) > 0 ? var.docker_http_proxy_password : ""
      port     = docker_http_proxy.value.port != null ? docker_http_proxy.value.port : 8080
      protocol = docker_http_proxy.value.protocol != null ? docker_http_proxy.value.protocol : "http"
      username = docker_http_proxy.value.username
    }
  }
  dynamic "docker_https_proxy" {
    for_each = { for k, v in each.value.docker_https_proxy : k => v if length(regexall("[a-zA-Z0-9]", v.hostname)) > 0 }
    content {
      hostname = docker_https_proxy.value.hostname
      password = length(regexall("[a-zA-Z]", docker_https_proxy.value.username)) > 0 ? var.docker_https_proxy_password : ""
      port     = docker_https_proxy.value.port != null ? docker_https_proxy.value.port : 8443
      protocol = docker_https_proxy.value.protocol != null ? docker_https_proxy.value.protocol : "https"
      username = docker_https_proxy.value.username
    }
  }
  dynamic "tags" {
    for_each = length(each.value.tags) > 0 ? each.value.tags : local.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
