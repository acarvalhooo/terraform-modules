# Creating role to be used by EFS CSI Driver and attaching policys
resource "aws_iam_role" "efs-csi-role" {
  name = "AmazonEFSCSIDriverRole-${var.project}-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["sts:AssumeRoleWithWebIdentity"],
      Principal = {
        Federated = var.oidc-issuer-arn
      },
      Condition = {
        StringLike = {
          "${var.cluster-oidc-url}:sub" = "system:serviceaccount:kube-system:aws-node",
          "${var.cluster-oidc-url}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "alb-controller-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = aws_iam_role.efs-csi-role.name
}

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
resource "helm_release" "efs-csi-driver" {
  name = "aws-efs-csi-driver"

  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"
  version    = var.chart-version

  set {
    name  = "clusterName"
    value = var.cluster-name
  }

  set {
    name  = "image.tag"
    value = var.application-version
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-efs-csi-driver"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.efs-csi-role.arn
  }

  depends_on = [
    aws_iam_role.efs-csi-role
  ]
}