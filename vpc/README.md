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

module "vpc" {
  source                     = "./vpc"
  vpc-cidr                   = "192.168.0.0/16"
  public-subnet-01-cidr      = "192.168.0.0/24"
  public-subnet-02-cidr      = "192.168.1.0/24"
  application-subnet-01-cidr = "192.168.2.0/24"
  application-subnet-02-cidr = "192.168.3.0/24"
  database-subnet-01-cidr    = "192.168.4.0/24"
  database-subnet-02-cidr    = "192.168.5.0/24"
  az-1                       = "us-east-1a"
  az-2                       = "us-east-1b"
  environment                = "prod"
  project                    = "sap"
}
```