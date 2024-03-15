# Retrieving caller identity
data "aws_caller_identity" "account-id" {}

# Configuring token to be used to apply the helm chart
data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster-name
}

# Configuring helm provider
provider "helm" {
  kubernetes {
    host                   = var.api-server-endpoint
    cluster_ca_certificate = base64decode(var.cluster-ca-certificate)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
  }
}

# Creating policy to be used by role
data "template_file" "policy-template" {
  template = file("${path.module}/policy.json")
}

resource "aws_iam_policy" "policy" {
  name   = local.policy-name
  policy = data.template_file.policy-template.rendered

  tags = {
    Name        = local.policy-name
    Project     = var.project
    Environment = var.environment
  }
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
            "${replace(var.cluster-oidc-url, "https://", "")}:sub" : "system:serviceaccount:kube-system:cluster-autoscaler",
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
    "attachment-01" = { name = aws_iam_policy.policy.name, policy_arn = aws_iam_policy.policy.arn }
  }

  roles      = [aws_iam_role.role.name]
  name       = each.value.name
  policy_arn = each.value.policy_arn
}

# Configuring release that will be applied
resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = var.chart-version

  set {
    name  = "image.tag"
    value = var.application-version
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster-name
  }

  set {
    name  = "autoDiscovery.tags"
    value = "k8s.io/cluster-autoscaler/enabled"
  }

  set {
    name  = "autoDiscovery.tags"
    value = "k8s.io/cluster-autoscaler/{{ .Values.autoDiscovery.clusterName }}"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.role.arn
  }
}