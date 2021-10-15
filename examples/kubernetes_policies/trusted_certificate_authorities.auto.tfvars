#__________________________________________________
#
# Trusted Certificate Authorities Policy Variables
#__________________________________________________

trusted_certificate_authorities = {
  "#Cluster#_registry" = {
    organization        = "default"
    unsigned_registries = ["10.101.128.128"]
  }
}
