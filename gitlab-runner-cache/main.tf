# Creating S3 bucket for store cache of Gitlab Runner
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket-name
  force_destroy = false

  tags = {
    Name        = var.bucket-name
    Project     = var.project
    Environment = var.environment
  }
}

# Configuring versioning in bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

# Creating role to be used by GitLab Runner and attaching policy
resource "aws_iam_role" "role" {
  name = var.role-name
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
            "${replace(var.cluster-oidc-url, "https://", "")}:sub" : "system:serviceaccount:${var.service-account}:${var.service-account}",
            "${replace(var.cluster-oidc-url, "https://", "")}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Name        = var.role-name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_iam_policy_attachment" "attachments" {
  for_each = {
    "attachment-01" = { name = "AmazonS3FullAccess", policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" }
  }

  roles      = [aws_iam_role.role.name]
  name       = each.value.name
  policy_arn = each.value.policy_arn
}