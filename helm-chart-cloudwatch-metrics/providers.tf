# Configuring helm provider
provider "helm" {
  kubernetes {
    host                   = var.api-server-endpoint
    cluster_ca_certificate = base64decode(var.cluster-ca-certificate)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
  }
}

# Configuring kubernetes provider
provider "kubernetes" {
  host                   = var.api-server-endpoint
  cluster_ca_certificate = base64decode(var.cluster-ca-certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster-name]
    command     = "aws"
  }
}