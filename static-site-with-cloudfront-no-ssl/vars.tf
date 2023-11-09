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