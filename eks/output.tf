# Cluster url oidc
output "cluster-oidc-url" {
  value = aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}

# Cluster name
output "cluster-name" {
  value = aws_eks_cluster.cluster.name
}

# API server endpoint
output "api-server-endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

# Cluster certificate
output "cluster-ca-certificate" {
  value = aws_eks_cluster.cluster.certificate_authority.0.data
}

# OIDC issuer arn
output "oidc-issuer-arn" {
  value = aws_iam_openid_connect_provider.oidc-provider.arn
}