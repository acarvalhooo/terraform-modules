# Environment
variable "environment" {
  description = "Environment where the resources are being created"
  default     = "development"
  type        = string
}

# VPC id
variable "vpc-id" {
  description = "VPC where the resources are being created"
  default     = ""
  type        = string
}

# Subnet ids
variable "application-subnet-01-id" {
  description = "First availability zone"
  default     = ""
  type        = string
}

variable "application-subnet-02-id" {
  description = "Second availability zone"
  default     = ""
  type        = string
}

# Kubernetes version
variable "eks-version" {
  description = "Version of kubernetes used in cluster"
  default     = "1.28"
  type        = string
}

# Addons versions
variable "coredns-version" {
  description = "Version of CoreDNS addon"
  default     = "v1.10.1-eksbuild.5"
  type        = string
}

variable "kube-proxy-version" {
  description = "Version of kube-proxy addon"
  default     = "v1.28.2-eksbuild.2"
  type        = string
}

variable "vpc-cni-version" {
  description = "Version of VPC-CNI addon"
  default     = "v1.15.3-eksbuild.1"
  type        = string
}