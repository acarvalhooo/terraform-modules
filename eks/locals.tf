# Key name
locals {
  key-name = "alias/${local.cluster-name}-key"
}

# Cluster name
locals {
  cluster-name = "eks-cluster-${var.project}-${var.environment}"
}

# Node group name
locals {
  node-group-name = "node-group-${var.project}-${var.environment}"
}