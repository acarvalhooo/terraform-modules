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