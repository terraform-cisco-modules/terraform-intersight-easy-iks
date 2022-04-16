#_______________________________________________________________
#
# Terraform Provider - Helm
# https://registry.terraform.io/providers/hashicorp/helm/latest
#_______________________________________________________________

provider "helm" {
  kubernetes {
    host                   = local.kubeconfigs[var.cluster_name].clusters[0].cluster.server
    client_certificate     = base64decode(local.kubeconfigs[var.cluster_name].users[0].user.client-certificate-data)
    client_key             = base64decode(local.kubeconfigs[var.cluster_name].users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kubeconfigs[var.cluster_name].clusters[0].cluster.certificate-authority-data)
  }
}
