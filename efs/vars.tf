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
  description = "VPC where the security group of EFS must be created"
  default     = ""
  type        = string
}

# Inbound CIDRs
variable "inbound-cidrs" {
  description = "CIDRs allowed to communicate with EFS"
  default     = []
  type        = list(string)
}

# Security groups IDs
variable "sg-ids" {
  description = "Security group IDs allowed comunicate with the EFS"
  default     = []
  type        = list(string)
}

# Encryption
variable "encryption" {
  description = "Encryption of EFS disk"
  default     = true
  type        = bool
}

# KMS key ID
variable "kms-key-id" {
  description = "KMS key ID used to encrypt the EFS disk"
  default     = ""
  type        = string
}

# Performance mode
variable "performance-mode" {
  description = "Performance mode of EFS"
  default     = ""
  type        = string
}

# Throughput mode
variable "throughput-mode" {
  description = "Throughput mode of EFS"
  default     = ""
  type        = string
}

# Provisioned MiBps
variable "provisioned-mibps" {
  description = "Provisioned throughput in MiBps"
  default     = ""
  type        = string
}

# Transition to IA
variable "transition-to-ia" {
  description = "Number of days before the file is stored in another class"
  default     = ""
  type        = string
}

# Subnet IDs
variable "application-subnet-01-id" {
  description = "First availability zone where the mount target must be created"
  default     = ""
  type        = string
}

variable "application-subnet-02-id" {
  description = "Second availability zone where the mount target must be created"
  default     = ""
  type        = string
}

# Backup
variable "backup" {
  description = "Automatic backup of EFS"
  default     = ""
  type        = string
}