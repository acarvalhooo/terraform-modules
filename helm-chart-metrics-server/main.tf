# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Creating namespace
resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "metrics-server"
  }
}

# Configuring release that will be applied
resource "helm_release" "aws-cloudwatch-metrics" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "metrics-server" 
  version    = var.chart-version

  set {
    name  = "image.tag"
    value = var.application-version
  }
}