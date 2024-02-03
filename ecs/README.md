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

module "ecs" {
  source       = "./ecs"
  project      = "sap"
  environment  = "prod"
  cpu          = 1024
  memory       = 2048
  network-mode = "awsvpc"
}
```