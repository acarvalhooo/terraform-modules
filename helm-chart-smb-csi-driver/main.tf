# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Creating role to be used by service account and attaching policys
resource "aws_iam_role" "role" {
  name = local.role-name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["sts:AssumeRoleWithWebIdentity"],
      Principal = {
        Federated = var.oidc-provider-arn
      },
      Condition = {
        StringLike = {
          "${var.cluster-oidc-url}:sub" = "system:serviceaccount:kube-system:aws-ebs-csi-driver",
          "${var.cluster-oidc-url}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  tags = {
    Name        = local.role-name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_iam_policy_attachment" "attachments" {
  for_each = {
    "attachment-01" = { policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" }
  }

  roles      = [aws_iam_role.role.name]
  name       = each.key
  policy_arn = each.value.policy_arn
}

# Configuring release that will be applied
resource "helm_release" "aws-ebs-csi-driver" {
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
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
    name  = "controller.serviceAccount.name"
    value = "aws-ebs-csi-driver"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.role.arn
  }
  
  depends_on = [aws_iam_role.role]
}