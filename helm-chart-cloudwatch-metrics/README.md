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

module "helm-chart-cloudwatch-metrics" {
  source                 = "./helm-chart-cloudwatch-metrics"
  cluster-name           = module.eks.cluster-name
  api-server-endpoint    = module.eks.api-server-endpoint
  cluster-ca-certificate = module.eks.cluster-ca-certificate
  oidc-provider-arn      = module.eks.oidc-provider-arn
  cluster-oidc-url       = module.eks.cluster-oidc-url
  namespace              = "amazon-cloudwatch"
  project                = "sap"
  environment            = "prod"
  chart-version          = "0.0.11"
  application-version    = "1.300032.2b361"
}
```