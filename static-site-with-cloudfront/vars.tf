# Bucket name
variable "bucket" {
  description = "Bucket name that its being used to host static site"
  default     = "my-bucket-for-store-static-site"
  type        = string
}

# Environment
variable "environment" {
  description = "Environment where the resources are being created"
  default     = "development"
  type        = string
}

# Custom domain
variable "custom-domain" {
  description = "Custom domain that must be used by CloudFront"
  default     = ""
  type        = string
}

# Certificate ARN
variable "certificate-arn" {
  description = "Certificate ARN that must be used by CloudFront to use a custom domain"
  default     = ""
  type        = string
}