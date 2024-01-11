# Creating role to be used by eks cluster and attaching policys
resource "aws_iam_role" "cluster-role" {
  name = "AmazonEKSClusterRole-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "attachments" {
  for_each = {
    "attachment-01" = { name = "AmazonEKSClusterPolicyAttachment", policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" }
    "attachment-02" = { name = "AmazonEKSServicePolicyAttachment", policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy" }
  }

  roles      = [aws_iam_role.cluster-role.name]
  name       = each.value.name
  policy_arn = each.value.policy_arn
}

# Creating kms key and alias to be used by secrets encryption
data "template_file" "kms-policy" {
  template = file("${path.module}/policy.json")

  vars = {
    cluster_role_arn = aws_iam_role.cluster-role.arn
  }
}

resource "aws_kms_key" "kms-key" {
  description             = "Key for ${local.cluster-name} secrets encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  policy                  = data.template_file.kms-policy.rendered

  tags = {
    Name        = local.key-name
    Environment = var.environment
  }
}

resource "aws_kms_alias" "kms-alias" {
  name          = local.key-name
  target_key_id = aws_kms_key.kms-key.key_id
}

# Creating eks cluster
resource "aws_eks_cluster" "cluster" {
  name     = local.cluster-name
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    subnet_ids = [
      var.application-subnet-01-id,
      var.application-subnet-02-id
    ]
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.kms-key.arn
    }
  }

  version = var.eks-version

  tags = {
    Name        = local.cluster-name
    Environment = var.environment
  }
}

# Creating oidc provider
data "tls_certificate" "oidc-certificate" {
  url = aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "oidc-provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc-certificate.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}

# Creating role to be used by managed node group and attaching policys
resource "aws_iam_role" "node-group-role" {
  name = "AmazonEKSNodeGroupRole-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "attachments-node-group" {
  for_each = {
    "attachment-01" = { name = "AmazonEC2ContainerRegistryReadOnly", policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" }
    "attachment-02" = { name = "AmazonEKS_CNI_Policy", policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" }
    "attachment-03" = { name = "AmazonEKSWorkerNodePolicy", policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" }
  }

  roles      = [aws_iam_role.node-group-role.name]
  name       = each.value.name
  policy_arn = each.value.policy_arn
}

# Creating spot managed node group
resource "aws_eks_node_group" "spot-node-group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "spot-${local.node-group-name}"
  node_role_arn   = aws_iam_role.node-group-role.arn

  scaling_config {
    min_size     = var.min-size
    desired_size = var.desired-size
    max_size     = var.max-size
  }

  ami_type       = var.ami-type
  capacity_type  = "SPOT"
  disk_size      = var.disk-size
  instance_types = var.instances-types
  subnet_ids     = [var.application-subnet-01-id, var.application-subnet-02-id]

  tags = {
    Name        = "spot-${local.node-group-name}"
    Environment = var.environment
  }
}

# Creating on-demand managed node group
resource "aws_eks_node_group" "on-demand-node-group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "on-demand-${local.node-group-name}"
  node_role_arn   = aws_iam_role.node-group-role.arn

  scaling_config {
    min_size     = var.min-size
    desired_size = var.desired-size
    max_size     = var.max-size
  }

  ami_type       = var.ami-type
  capacity_type  = "ON_DEMAND"
  disk_size      = var.disk-size
  instance_types = var.instances-types
  subnet_ids     = [var.application-subnet-01-id, var.application-subnet-02-id]

  tags = {
    Name        = "on-demand-${local.node-group-name}"
    Environment = var.environment
  }
}

# Installing add-ons
resource "aws_eks_addon" "add-ons" {
  for_each = {
    "coredns"    = { addon_name = "coredns", addon_version = var.coredns-version }
    "kube-proxy" = { addon_name = "kube-proxy", addon_version = var.kube-proxy-version }
    "vpc-cni"    = { addon_name = "vpc-cni", addon_version = var.vpc-cni-version }
  }

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = each.value.addon_name
  addon_version               = each.value.addon_version

  depends_on = [ aws_eks_node_group.spot-node-group, aws_eks_node_group.on-demand-node-group ]
}