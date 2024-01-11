# VPC CIDR
variable "vpc-cidr" {
  description = "CIDR used in VPC"
  default     = ""
  type        = string
}

# Subnets CIDRs
variable "sn-pub-01-cidr" {
  description = "CIDR used in first public subnet"
  default     = ""
  type        = string
}

variable "sn-pub-02-cidr" {
  description = "CIDR used in second public subnet"
  default     = ""
  type        = string
}

variable "sn-app-01-cidr" {
  description = "CIDR used in first application subnet"
  default     = ""
  type        = string
}

variable "sn-app-02-cidr" {
  description = "CIDR used in second application subnet"
  default     = ""
  type        = string
}

variable "sn-db-01-cidr" {
  description = "CIDR used in first database subnet"
  default     = ""
  type        = string
}

variable "sn-db-02-cidr" {
  description = "CIDR used in second database subnet"
  default     = ""
  type        = string
}

# Internet CIDR block
variable "internet-cidr" {
  description = "Internet CIDR as target for route tables"
  default     = "0.0.0.0/0"
  type        = string
}

# Availability zones
variable "az-1" {
  description = "First availability zone"
  default     = ""
  type        = string
}

variable "az-2" {
  description = "Second availability zone"
  default     = ""
  type        = string
}

# DNS support to VPC
variable "dns-support" {
  description = "Resolution of DNS in VPC"
  default     = true
  type        = bool
}

# Public IP on launch
variable "map-public-ip" {
  description = "Map public IP to resources in public subnets"
  default     = true
  type        = bool
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