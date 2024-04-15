# Cluster name
variable "cluster-name" {
  description = "Name of cluster where the chart will be applied"
  default     = ""
  type        = string
}

# API server endpoint
variable "api-server-endpoint" {
  description = "API server endpoint of cluster where the chart will be applied"
  default     = ""
  type        = string
}

# Cluster CA certificate
variable "cluster-ca-certificate" {
  description = "Cluster CA certificate of cluster where the chart will be applied"
  default     = ""
  type        = string
}

# Namespace
variable "namespace" {
  description = "Namespace where the chart will be applied"
  default     = ""
  type        = string
}

# Chart version
variable "chart-version" {
  description = "Chart version"
  default     = ""
  type        = string
}

# Controller service type
variable "controller-service-type" {
  description = "Controller service type"
  default     = ""
  type        = string
}