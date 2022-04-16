#______________________________________________________________
#
# Terraform Cloud Provider
# https://registry.terraform.io/providers/hashicorp/tfe/latest
#______________________________________________________________

terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.30.2"
    }
  }
}

provider "tfe" {
  # Configuration options
  hostname = "app.terraform.io"
  token    = var.terraform_cloud_token
}
