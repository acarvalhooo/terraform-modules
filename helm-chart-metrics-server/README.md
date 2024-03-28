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

module "helm-chart-metrics-server" {
  source                 = "./helm-chart-metrics-server"
  cluster-name           = module.eks.cluster-name
  api-server-endpoint    = module.eks.api-server-endpoint
  cluster-ca-certificate = module.eks.cluster-ca-certificate
  namespace              = "metrics-server"
  chart-version          = "3.12.0"
  application-version    = "v0.7.0"
}
```