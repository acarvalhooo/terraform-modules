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

# CPU
variable "cpu" {
  description = "CPU necessary to run task"
  default     = ""
  type        = string
}

# Memory
variable "memory" {
  description = "Memory necessary to run task"
  default     = ""
  type        = string
}

# Network mode
variable "network-mode" {
  description = "Network mode used by task"
  default     = ""
  type        = string
}