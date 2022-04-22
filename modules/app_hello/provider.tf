#_______________________________________________________________
#
# Terraform Provider - Helm
# https://registry.terraform.io/providers/hashicorp/helm/latest
#_______________________________________________________________

provider "helm" {
  kubernetes {
    host                   = local.kubeconfig.clusters[0].cluster.server
    client_certificate     = base64decode(local.kubeconfig.users[0].user.client-certificate-data)
    client_key             = base64decode(local.kubeconfig.users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kubeconfig.clusters[0].cluster.certificate-authority-data)
  }
}
