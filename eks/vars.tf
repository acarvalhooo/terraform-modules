# Environment
variable "environment" {
  description = "Environment where the resources are being created"
  default     = ""
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
  description = "First availability zone where the cluster must be created"
  default     = ""
  type        = string
}

variable "application-subnet-02-id" {
  description = "Second availability zone where the cluster must be created"
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
  default     = "v1.10.1-eksbuild.6"
  type        = string
}

variable "kube-proxy-version" {
  description = "Version of kube-proxy addon"
  default     = "v1.28.4-eksbuild.4"
  type        = string
}

variable "vpc-cni-version" {
  description = "Version of VPC-CNI addon"
  default     = "v1.16.0-eksbuild.1"
  type        = string
}

# Scaling config
variable "min-size" {
  description = "Minimun nodes quantity running in EKS"
  default     = "0"
  type        = string
}

variable "desired-size" {
  description = "Desired nodes quantity running in EKS"
  default     = "1"
  type        = string
}

variable "max-size" {
  description = "Maximum nodes quantity running in EKS"
  default     = "2"
  type        = string
}

# AMI type
variable "ami-type" {
  description = "AMI used by nodes"
  default     = "AL2_x86_64"
  type        = string
}

# Disk size
variable "disk-size" {
  description = "Disk size of nodes"
  default     = "50"
  type        = string
}

# Instances types
variable "instances-types" {
  description = "Instances type of nodes"
  default     = ["t3.medium"]
  type        = list(string)
}