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
  vpc-id                = "vpc-0000000000000"
  database-subnet-01-id = "subnet-0000000000000"
  database-subnet-02-id = "subnet-0000000000001"
  db-port               = 3306
  protocol              = "tcp"
  inbound-cidrs         = ["192.168.0.100/32", "192.168.0.101/32"]
  sg-ids                = ["sg-00000000000000000", "sg-00000000000000001"]
  engine                = "mysql"
  engine-version        = "8.0.35"
  root-user             = "admin"
  instance-type         = "db.t3.micro"
  storage               = 1024
  max-storage           = 2048
  skip-final-snapshot   = true
  certificate           = "rds-ca-rsa4096-g1"
  environment           = "prod"
  project               = "sap"
}
```