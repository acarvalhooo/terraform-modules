# Security group name
locals {
  efs-sg-name = "efs-sg-${var.project}-${var.environment}"
}

# EFS name
locals {
  efs-name = "efs-${var.project}-${var.environment}"
}