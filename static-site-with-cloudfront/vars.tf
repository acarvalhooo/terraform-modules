# Bucket name
variable "bucket-name" {
  description = "Bucket name that its being used to host static site"
  default     = ""
  type        = string
}

# Versioning
variable "versioning" {
  description = "Enable versioning in bucket"
  default     = ""
  type        = string
}

# Custom domain
variable "custom-domain" {
  description = "Custom domain that must be used by CloudFront"
  default     = []
  type        = list(string)
}

# Certificate ARN
variable "certificate-arn" {
  description = "Certificate ARN that must be used by CloudFront to use a custom domain"
  default     = ""
  type        = string
}

# Root object
variable "root-object" {
  description = "Name of main object"
  default     = ""
  type        = string
}

# Environment
variable "environment" {
  description = "Environment where the resources are being created"
  default     = ""
  type        = string
}

# Project
variable "project" {
  description = "Project name"
  default     = ""
  type        = string
}