# VPC ID
variable "vpc-id" {
  description = "VPC where the cluster must be created"
  default     = ""
  type        = string
}

# Subnet IDs
variable "database-subnet-01-id" {
  description = "First availability zone where the subnet group must be created"
  default     = ""
  type        = string
}

variable "database-subnet-02-id" {
  description = "Second availability zone where the subnet group must be created"
  default     = ""
  type        = string
}

# Database port
variable "db-port" {
  description = "Port used by database"
  default     = ""
  type        = string
}

# Inbound CIDRs
variable "inbound-cidrs" {
  description = "CIDRs allowed to communicate with database"
  default     = []
  type        = list(string)
}

# Protocol
variable "protocol" {
  description = "Inbound protocol allowed"
  default     = ""
  type        = string
}

# Security groups IDs
variable "sg-ids" {
  description = "Security group ids allowed comunicate with the database"
  default     = []
  type        = list(string)
}

# Availability zones
variable "availability-zones" {
  description = "Availability zones where the instances can be created"
  default     = []
  type        = list(string)
}

# Engine
variable "engine" {
  description = "Engine used by database"
  default     = ""
  type        = string
}

# Engine version
variable "engine-version" {
  description = "Engine version"
  default     = ""
  type        = string
}

# Root user
variable "root-user" {
  description = "Name of root user"
  default     = ""
  type        = string
}

# Delete protection
variable "delete-protection" {
  description = "Protect against deletions"
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