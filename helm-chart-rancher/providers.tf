# Configuring helm provider
provider "helm" {
  kubernetes {
    host                   = var.api-server-endpoint
    cluster_ca_certificate = base64decode(var.cluster-ca-certificate)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
  }
}