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

module "alb-controller" {
  source                 = "./alb-controller"
  cluster-oidc-url       = "https://oidc.eks.region-code.amazonaws.com/id/thumbprint-code"
  project                = "sap"
  environment            = "prod"
  cluster-name           = "eks-cluster-sap-prod"
  api-server-endpoint    = "Get this value from eks console identified by 'API server endpoint'"
  cluster-ca-certificate = "Get this value from eks console identified by 'Certificate authority'"
  chart-version          = "1.7.1"
  application-version    = "v2.7.1"
}
```
# Observation
Access https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller for verify the chart and application version available
