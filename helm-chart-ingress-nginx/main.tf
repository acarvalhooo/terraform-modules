# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Configuring release that will be applied
resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = var.namespace
  version          = var.chart-version
  create_namespace = true

  set {
    name  = "controller.service.type"
    value = var.controller-service-type
  }
}