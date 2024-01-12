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

module "static-site" {
  source         = "./static-site"
  bucket-name    = "my-favorite-bucket"
  versioning     = "Enabled"
  environment    = "prod"
  project        = "sap"
}
```