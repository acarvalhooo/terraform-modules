# Retrieving caller identity
data "aws_caller_identity" "account-id" {}

# Trust relationship to be used by load balancer controller
data "aws_iam_policy_document" "trust-alb-controller" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.account-id.account_id}:oidc-provider/${replace(var.cluster-oidc-url, "https://", "")}"]
    }

    condition {
      test     = "StringLike"
      variable = "${replace(var.cluster-oidc-url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    condition {
      test     = "StringLike"
      variable = "${replace(var.cluster-oidc-url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# Creating policy to be used by load balancer controller
data "template_file" "alb-policy-file" {
  template = file("${path.module}/policy.json")
}

resource "aws_iam_policy" "alb-policy" {
  name   = "AmazonEKSLoadBalancerControllerPolicy-${var.project}-${var.environment}"
  policy = data.template_file.alb-policy-file.rendered
}

# Creating role to be used by load balancer controller
resource "aws_iam_role" "alb-controller-role" {
  name               = "AmazonEKSLoadBalancerControllerRole-${var.project}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.trust-alb-controller.json
}

resource "aws_iam_role_policy_attachment" "alb-controller-policy-attachment" {
  policy_arn = aws_iam_policy.alb-policy.arn
  role       = aws_iam_role.alb-controller-role.name
}

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

# Configuring release that will be used
resource "helm_release" "aws-load-balancer-controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
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
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb-controller-role.arn
  }

  depends_on = [
    aws_iam_role.alb-controller-role
  ]
}