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

module "cache" {
  source            = "./gitlab-runner-cache"
  bucket-name       = "my-bucket"
  project           = "runner"
  environment       = "dev"
  versioning        = "Enabled"
  role-name         = "GitlabRunnerCacheInS3"
  oidc-provider-arn = "arn:aws:iam::account-id:oidc-provider/oidc.eks.region-code.amazonaws.com/id/thumbrint-code"
  cluster-oidc-url  = "https://oidc.eks.region-code.amazonaws.com/id/thumbprint-code"
  service-account   = "gitlab-runner"
}
```