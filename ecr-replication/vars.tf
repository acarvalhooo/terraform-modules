# Regions
variable "replication-regions" {
  description = "Regions that the ECR repositorys must be replicated"
  default     = [""]
  type        = list(string)
}

# Prefix
variable "prefix" {
  description = "Prefix of repositorys that will be replicated"
  default     = [""]
  type        = string
}