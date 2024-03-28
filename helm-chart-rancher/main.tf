# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Configuring release that will be applied
resource "helm_release" "rancher" {
  name             = "rancher"
  chart            = "${path.module}/rancher"
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "ingress.ingressClassName"
    value = var.ingress-class
  }

  set {
    name  = "hostname"
    value = var.hostname
  }

  set {
    name  = "replicas"
    value = var.replicas
  }
}