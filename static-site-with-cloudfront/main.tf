# Creating S3 bucket for static site
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket-name
  force_destroy = false

  tags = {
    Name        = var.bucket-name
    Environment = var.environment
    Project     = var.project
  }
}

# Enabling versioning in bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

# Creating origin control access
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "S3-OAC"
  description                       = "Origin Access Control that must be used by buckets"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Creating cloudfront distribution
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    origin_id                = aws_s3_bucket.bucket.bucket_domain_name
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  aliases             = var.custom-domain
  comment             = local.comment
  enabled             = true
  default_root_object = var.root-object

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.bucket.bucket_domain_name
    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = var.certificate-arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  tags = {
    Name        = local.comment
    Environment = var.environment
    Project     = var.project
  }
}

# Creating bucket policy to allow access from cloudfront
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = templatefile("${path.module}/policy.json", {
    bucket_arn     = aws_s3_bucket.bucket.arn
    cloudfront_arn = aws_cloudfront_distribution.distribution.arn
  })

  depends_on = [aws_s3_bucket.bucket, aws_cloudfront_distribution.distribution]
}