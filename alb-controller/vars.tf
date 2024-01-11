# Cluster URL OIDC
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

# Cluster CA certificate
variable "cluster-ca-certificate" {
  description = "Cluster CA certificate"
  default     = ""
  type        = string
}

# Environment
variable "environment" {
  description = "Environment where the resources are being launched"
  default     = ""
  type        = string
}

###############################################################################################################
## The default values below are the latest version available when this code was created. If you want to make ##
## sure it's still the latest, access: https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller ##
###############################################################################################################

# Chart version
variable "chart-version" {
  description = "Chart version"
  default     = "1.6.2"
  type        = string
}

# Application version
variable "application-version" {
  description = "Application version"
  default     = "v2.6.2"
  type        = string
}