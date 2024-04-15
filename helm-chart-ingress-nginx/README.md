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

module "helm-chart-ingress-nginx" {
  source                  = "./helm-chart-ingress-nginx"
  cluster-name            = module.eks.cluster-name
  api-server-endpoint     = module.eks.api-server-endpoint
  cluster-ca-certificate  = module.eks.cluster-ca-certificate
  namespace               = "ingress-nginx"
  chart-version           = "4.10.0"
  controller-service-type = "LoadBalancer"
}
```
