# Policy name
locals {
  policy-name = "AmazonEKSAutoScalerPolicy-${var.project}-${var.environment}"
}

# Role name
locals {
  role-name = "AmazonEKSAutoScalerRole-${var.project}-${var.environment}"
}