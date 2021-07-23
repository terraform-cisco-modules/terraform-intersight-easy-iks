output "ip_pools" {
  value = yamldecode(var.pool_1)
}

variable "pool_1" {}
