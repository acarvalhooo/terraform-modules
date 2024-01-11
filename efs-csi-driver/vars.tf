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

# Environment
variable "environment" {
  description = "Environment where the resources are being launched"
  default     = ""
  type        = string
}

#######################################################################################################
## The default values below are the latest version available when this code was created. If you want ##
## to make sure it's still the latest, access: https://github.com/kubernetes-sigs/aws-efs-csi-driver ##
#######################################################################################################

# Chart version
variable "chart-version" {
  description = "Chart version"
  default     = "2.5.3"
  type        = string
}

# Application version
variable "application-version" {
  description = "Application version"
  default     = "v1.7.3"
  type        = string
}