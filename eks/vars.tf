# VPC ID
variable "vpc-id" {
  description = "VPC where the cluster must be created"
  default     = ""
  type        = string
}

# Subnet IDs
variable "application-subnet-01-id" {
  description = "First availability zone where the cluster and node group must be created"
  default     = ""
  type        = string
}

variable "application-subnet-02-id" {
  description = "Second availability zone where the cluster and node group must be created"
  default     = ""
  type        = string
}

# EKS version
variable "eks-version" {
  description = "EKS version"
  default     = ""
  type        = string
}

# Add-ons versions
variable "coredns-version" {
  description = "Version of CoreDNS add-on"
  default     = ""
  type        = string
}

variable "kube-proxy-version" {
  description = "Version of Kube-Proxy add-on"
  default     = ""
  type        = string
}

variable "vpc-cni-version" {
  description = "Version of VPC-CNI add-on"
  default     = ""
  type        = string
}

# Scaling config
variable "min-size" {
  description = "Minimun nodes quantity running in EKS"
  default     = ""
  type        = string
}

variable "desired-size" {
  description = "Desired nodes quantity running in EKS"
  default     = ""
  type        = string
}

variable "max-size" {
  description = "Maximum nodes quantity running in EKS"
  default     = ""
  type        = string
}

# AMI type
variable "ami-type" {
  description = "AMI used by nodes"
  default     = ""
  type        = string
}

# Disk size
variable "disk-size" {
  description = "Disk size of nodes"
  default     = ""
  type        = string
}

# Instances types
variable "instances-types" {
  description = "Instances type of nodes"
  default     = []
  type        = list(string)
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