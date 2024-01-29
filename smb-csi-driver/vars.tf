# Cluster name
variable "cluster-name" {
  description = "Name of cluster that the controller will be installed"
  default     = ""
  type        = string
}

# API server endpoint
variable "endpoint" {
  description = "API server endpoint of cluster"
  default     = ""
  type        = string
}

# Cluster CA certificate
variable "cluster-ca-certificate" {
  description = "Cluster CA certificate"
  default     = ""
  type        = string
}

# Chart version
variable "chart-version" {
  description = "Chart version"
  default     = ""
  type        = string
}