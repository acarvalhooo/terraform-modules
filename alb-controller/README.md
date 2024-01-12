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
  cluster-oidc-url       = "https://oidc.eks.us-east-1.amazonaws.com/id/A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0"
  cluster-name           = "eks-cluster-sap-prod"
  endpoint               = "https://A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0.A0A.us-east-1.eks.amazonaws.com"
  cluster-ca-certificate = "Get this value from eks console identified by 'Certificate authority'"
  chart-version          = "1.6.2"
  application-version    = "v2.6.2"
  environment            = "prod"
  project                = "sap
}
```
# Observation
Access https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller for verify the chart and application version available