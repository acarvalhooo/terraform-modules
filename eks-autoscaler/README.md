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

module "eks-autoscaler" {
  source                 = "./eks-autoscaler"
  cluster-name           = module.eks.cluster-name
  api-server-endpoint    = module.eks.api-server-endpoint
  cluster-ca-certificate = module.eks.cluster-ca-certificate
  project                = "sap"
  environment            = "prod"
  oidc-provider-arn      = module.eks.oidc-provider-arn
  cluster-oidc-url       = module.eks.cluster-oidc-url
  chart-version          = "9.35.0"
  application-version    = "v1.29.0"
}
```