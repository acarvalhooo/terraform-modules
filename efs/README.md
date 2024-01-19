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

module "efs" {
  source                   = "./efs"
  project                  = "sap"
  environment              = "prod"
  vpc-id                   = "vpc-00000000000000000"
  inbound-cidrs            = ["192.168.0.0/16"]
  sg-ids                   = ["sg-00000000000000000"]
  encryption               = true
  performance-mode         = "generalPurpose"
  throughput-mode          = "bursting"
  transition-to-ia         = "AFTER_7_DAYS"
  application-subnet-01-id = "subnet-00000000000000000"
  application-subnet-02-id = "subnet-00000000000000001"
  backup                   = "ENABLED" 
}
```