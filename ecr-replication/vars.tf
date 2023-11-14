# Regions
variable "replicate_region" {
  description = "Regions that the ECR repositorys will be replicated"
  default     = ["sa-east-1"]
  type        = list(string)
}

# Prefix
variable "prefix" {
  description = "Prefix of repositorys that will be replicated"
  default     = [""]
  type        = string
}