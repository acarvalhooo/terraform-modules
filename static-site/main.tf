# Creating S3 bucket for static site
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket
  force_destroy = false

  tags = {
    Name        = var.bucket
    Environment = var.environment
  }
}

# Enabling versioning to the bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Setting rules to allow public access
resource "aws_s3_bucket_public_access_block" "rules" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = var.disabling-rules
  block_public_policy     = var.disabling-rules
  ignore_public_acls      = var.disabling-rules
  restrict_public_buckets = var.disabling-rules
}

# Defining ownership
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Defining acls
resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_public_access_block.rules,
    aws_s3_bucket_ownership_controls.ownership,
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

# Creating bucket policy to allow public access
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = templatefile("${path.module}/policy.json", {
    bucket_arn = aws_s3_bucket.bucket.arn
  })

  depends_on = [aws_s3_bucket_public_access_block.rules]
}

# Enabling static site
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}