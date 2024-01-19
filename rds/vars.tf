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

# VPC ID
variable "vpc-id" {
  description = "VPC where the security group of RDS must be created"
  default     = ""
  type        = string
}

# Database port
variable "db-port" {
  description = "Port used by database"
  default     = ""
  type        = string
}

# Protocol
variable "protocol" {
  description = "Inbound protocol allowed"
  default     = ""
  type        = string
}

# Inbound CIDRs
variable "inbound-cidrs" {
  description = "CIDRs allowed to communicate with database"
  default     = []
  type        = list(string)
}

# Security groups IDs
variable "sg-ids" {
  description = "Security group IDs allowed comunicate with the database"
  default     = []
  type        = list(string)
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

# Storage
variable "storage" {
  description = "Disk size"
  default     = ""
  type        = string
}

# Max storage
variable "max-storage" {
  description = "Max disk size"
  default     = ""
  type        = string
}

# Instance type
variable "instance-type" {
  description = "Instance type"
  default     = ""
  type        = string
}

# Root user
variable "root-user" {
  description = "Name of root user"
  default     = ""
  type        = string
}

# Multi-az
variable "multi-az" {
  description = "Multi az instance"
  default     = false
  type        = bool
}

# Delete protection
variable "delete-protection" {
  description = "Protect against deletions"
  default     = true
  type        = bool
}

# Certificate
variable "certificate" {
  description = "SSL certificate used by instance"
  default     = ""
  type        = string
}

# Skip final snapshot
variable "skip-final-snapshot" {
  description = "Skip final snapshot before delete"
  default     = true
  type        = bool
}