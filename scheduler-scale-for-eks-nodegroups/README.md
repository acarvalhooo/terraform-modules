# Using the module via orchestrator (Example)
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "scheduler-scale-for-eks-nodegroups" {
  source         = "./scheduler-scale-for-eks-nodegroups"
  cluster-name   = module.eks.cluster-name
  project        = "sap"
  environment    = "prod"
  lambda-runtime = "python3.8"
  lambda-timeout = 15
  cron-scaleup   = "cron(0 8 ? * MON-FRI *)"
  cron-scaledown = "cron(0 20 ? * MON-FRI *)"
  timezone       = "Brazil/East"
}
```
# Observation
Insert manually node group name in .py files