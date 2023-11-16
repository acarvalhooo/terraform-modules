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
variable "api-server-endpoint" {
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

# OIDC issuer arn
variable "oidc-issuer-arn" {
  description = "OIDC issuer arn"
  default     = ""
  type        = string
}