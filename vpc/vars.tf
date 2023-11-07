# Environment
variable "environment" {
  description = "Environment where the resources are being created"
  default     = "development"
  type        = string
}

# DNS support to VPC
variable "dns-support" {
  description = "Enable or disable resolution of dns in VPC"
  default     = true
  type        = bool
}

# Availability zones
variable "az-1" {
  description = "First availability zone"
  default     = "us-east-1a"
  type        = string
}

variable "az-2" {
  description = "Second availability zone"
  default     = "us-east-1b"
  type        = string
}

# Public ip on launch
variable "map-public-ip" {
  description = "If resources created in public subnet should have a public ip or no"
  default     = true
  type        = bool
}

# Internet cidr block
variable "internet-cidr-block" {
  description = "Internet cidr as target for route tables"
  default     = "0.0.0.0/0"
  type        = string
}
