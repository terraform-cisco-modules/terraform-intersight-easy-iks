#______________________________________________
#
# Node OS Configuration Policy Variables
#______________________________________________

nodeos_configuration_policies = {
  Wakanda_nodeos_config = {
    dns_servers_v4 = ["10.101.128.15", "10.101.128.16"]
    domain_name    = "rich.ciscolabs.com"
    #  If ntp_servers is not set, dns_servers will be used as NTP servers
    # ntp_servers = []
    organization = "Wakanda"
    # For a List of timezones see
    # https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md.
    timezone = "America/New_York"
  }
}
