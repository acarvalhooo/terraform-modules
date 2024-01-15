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

module "rds" {
  source                = "./rds"
  vpc-id                = "vpc-0000000000000"
  database-subnet-01-id = "subnet-0000000000000"
  database-subnet-02-id = "subnet-0000000000001"
  db-port               = 3306
  protocol              = "tcp"
  inbound-cidrs         = ["8.8.8.8/32", "8.8.4.4/32"]
  sg-ids                = ["sg-00000000000000000", "sg-00000000000000001"]
  environment           = "prod"
  project               = "sap"
}
```
# Observation
This module is maintenance, then its missing somethings