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
  source                = "./Terraform-Modules/rds"
  vpc-id                = "vpc-0d9f1e6812aea9344"
  database-subnet-01-id = "subnet-0d9d63b12babf04f8"
  database-subnet-02-id = "subnet-050fd0cbd37dab1f2"
  db-port               = 3306
  protocol              = "tcp"
  inbound-cidrs         = ["8.8.8.8/32", "8.8.4.4/32"]
  sg-ids                = ["sg-00000000000000000", "sg-00000000000000001"]
  engine                = "mysql"
  engine-version        = "8.0.35"
  root-user             = "admin"
  instance-type         = "db.t3.micro"
  storage               = 1024
  max-storage           = 2048
  delete-protection     = false
  skip-final-snapshot   = true
  certificate           = "rds-ca-rsa4096-g1"
  environment           = "prod"
  project               = "sap"
}
```