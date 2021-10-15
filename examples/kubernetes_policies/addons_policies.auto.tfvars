#______________________________________________
#
# Add-ons Policies Variables
#______________________________________________

addons_policies = {
  ccp-monitor = {
    organization = "default"
    # This is empty because I am accepting all the default values
  }
  kubernetes-dashboard = {
    install_strategy = "InstallOnly"
    organization     = "default"
    upgrade_strategy = "AlwaysReinstall"
  }
}

