# Cluster name
variable "cluster-name" {
  description = "Name of the cluster the node groups belong to"
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

# Lambda runtime
variable "lambda-runtime" {
  description = "Runtime of lambda functions"
  default     = ""
  type        = string
}

# Lambda timeout
variable "lambda-timeout" {
  description = "Timeout of lambda functions"
  default     = ""
  type        = string
}

# Cron scale up
variable "cron-scaleup" {
  description = "Cron expression of scale up"
  default     = ""
  type        = string
}

# Cron scale down
variable "cron-scaledown" {
  description = "Cron expression of scale down"
  default     = ""
  type        = string
}

# Timezone
variable "timezone" {
  description = "Timezone"
  default     = ""
  type        = string
}