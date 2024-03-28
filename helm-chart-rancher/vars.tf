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

# Ingress class
variable "ingress-class" {
  description = "Name of ingress class"
  default     = ""
  type        = string
}

# Hostname
variable "hostname" {
  description = "Fully qualified domain of rancher"
  default     = ""
  type        = string
}

# Replicas
variable "replicas" {
  description = "Number of pods"
  default     = ""
  type        = string
}