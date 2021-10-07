#________________________________________________
#
# Virtual Machine Instance Type Policy Variables
#________________________________________________

virtual_machine_instance_type = {
  Wakanda_large = {
    cpu          = 12
    disk         = 80
    memory       = 32768
    organization = "Wakanda"
  }
  Wakanda_medium = {
    cpu          = 8
    disk         = 60
    memory       = 24576
    organization = "Wakanda"
  }
  Wakanda_small = {
    organization = "Wakanda"
    # This is empty because I am accepting all the default values
  }
}
