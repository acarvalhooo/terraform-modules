# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Configuring helm provider
provider "helm" {
  kubernetes {
    host                   = var.endpoint
    cluster_ca_certificate = base64decode(var.cluster-ca-certificate)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
  }
}

# Configuring release that will be used
resource "helm_release" "csi-driver-smb" {
  name = "csi-driver-smb"

  repository = "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
  chart      = "csi-driver-smb"
  namespace  = "kube-system"
  version    = var.chart-version

  set {
    name  = "clusterName"
    value = var.cluster-name
  }

  set {
    name  = "serviceAccount.name"
    value = "csi-driver-smb"
  }
}