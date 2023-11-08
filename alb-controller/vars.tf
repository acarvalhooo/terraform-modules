# Cluster url oidc
variable "cluster-oidc-url" {
  description = "URL of cluster OIDC"
  default     = ""
  type        = string
}

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