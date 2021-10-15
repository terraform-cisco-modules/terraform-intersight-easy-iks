#________________________________________________
#
# Virtual Machine Instance Type Policy Variables
#________________________________________________

virtual_machine_instance_type = {
  "#Cluster#_large" = {
    cpu          = 12
    disk         = 80
    memory       = 32768
    organization = "default"
  }
  "#Cluster#_medium" = {
    cpu          = 8
    disk         = 60
    memory       = 24576
    organization = "default"
  }
  "#Cluster#_small" = {
    organization = "default"
    # This is empty because I am accepting all the default values
  }
}
