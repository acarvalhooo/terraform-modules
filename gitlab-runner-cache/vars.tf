# Bucket name
variable "bucket-name" {
  description = "Bucket name that is being used to store cache of Gitlab Runner"
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

# Role name
variable "role-name" {
  description = "Role name used by Gitlab Runner"
  default     = ""
  type        = string
}

# OIDC provider ARN
variable "oidc-provider-arn" {
  description = "OIDC provider ARN of cluster where the Gitlab Runner is deployed"
  default     = ""
  type        = string
}

# Cluster OIDC URL
variable "cluster-oidc-url" {
  description = "OIDC URL of cluster where the Gitlab Runner is deployed"
  default     = ""
  type        = string
}

# Service account
variable "service-account" {
  description = "Service account name used by Gitlab Runner"
  default     = ""
  type        = string
}