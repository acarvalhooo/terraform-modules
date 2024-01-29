# Bucket name
variable "bucket-name" {
  description = "Bucket name that its being used to host static site"
  default     = ""
  type        = string
}

# Project
variable "project" {
  description = "Project name"
  default     = ""
  type        = string
}


# Environment
variable "environment" {
  description = "Environment where the resources are being created"
  default     = ""
  type        = string
}

# Versioning
variable "versioning" {
  description = "Enable versioning in bucket"
  default     = ""
  type        = string
}

# Index object
variable "index-object" {
  description = "Name of index object"
  default     = ""
  type        = string
}

# Error object
variable "error-object" {
  description = "Name of error object"
  default     = ""
  type        = string
}