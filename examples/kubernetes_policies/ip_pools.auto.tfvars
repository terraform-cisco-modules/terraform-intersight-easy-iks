#______________________________________________
#
# IP Pool Variables
#______________________________________________

ip_pools = {
  "#Cluster#_pool_v4" = {
    assignment_order = "sequential"
    ipv4_block = [
      {
        from = "10.96.110.101"
        to   = "10.96.110.200"
      },
    ]
    ipv4_config = {
      config = {
        gateway       = "10.96.110.1"
        netmask       = "255.255.255.0"
        primary_dns   = "10.101.128.15"
        secondary_dns = "10.101.128.16"
      }
    }
    ipv6_block   = []
    ipv6_config  = {}
    organization = "default"
    tags         = []
  }
  "#Cluster#_pool_v6" = {
    assignment_order = "sequential"
    ipv4_block       = []
    ipv4_config      = {}
    ipv6_block = [
      {
        from = "2001:110::101"
        size = 99
      }
    ]
    ipv6_config = {
      config = {
        gateway       = "2001:110::1"
        prefix        = 64
        primary_dns   = "2620:119:35::35"
        secondary_dns = "2620:119:53::53"
      }
    }
    organization = "default"
    tags         = []
  }
}
