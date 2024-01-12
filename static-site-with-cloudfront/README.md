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

module "static-site-with-cloudfront" {
  source          = "./static-site-with-cloudfront"
  bucket-name     = "my-favorite-bucket"
  versioning      = "Enabled"
  custom-domain   = ["example.com", "second.example.com"]
  certificate-arn = "arn:aws:acm:us-east-1:012345678901:certificate/a0a0a0a0-a0a0-a0a0-a0a0-a0a0a0a0a0a0"
  root-object     = "index.html"
  environment     = "prod"
  project         = "sap"
}
```