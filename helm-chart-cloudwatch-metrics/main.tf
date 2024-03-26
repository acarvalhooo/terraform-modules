# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Creating role to be used by service account and attaching policys
resource "aws_iam_role" "role" {
  name = local.role-name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : var.oidc-provider-arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${replace(var.cluster-oidc-url, "https://", "")}:sub" : "system:serviceaccount:amazon-cloudwatch:aws-cloudwatch-metrics",
            "${replace(var.cluster-oidc-url, "https://", "")}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Name        = local.role-name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_iam_policy_attachment" "attachments" {
  for_each = {
    "attachment-01" = { policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" }
  }

  name       = each.key
  roles      = [aws_iam_role.role.name]
  policy_arn = each.value.policy_arn
}

# Creating namespace
resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "amazon-cloudwatch"
  }
}

# Configuring release that will be applied
resource "helm_release" "aws-cloudwatch-metrics" {
  name       = "aws-cloudwatch-metrics"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-cloudwatch-metrics"
  namespace  = "amazon-cloudwatch"
  version    = var.chart-version

  set {
    name  = "image.tag"
    value = var.application-version
  }

  set {
    name  = "clusterName"
    value = var.cluster-name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.role.arn
  }
}