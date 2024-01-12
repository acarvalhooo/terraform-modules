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

module "efs-csi-driver" {
  source                 = "./efs-csi-driver"
  cluster-oidc-url       = "https://oidc.eks.us-east-1.amazonaws.com/id/A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0"
  cluster-name           = "eks-cluster-sap-prod"
  endpoint               = "https://A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0.A0A.us-east-1.eks.amazonaws.com"
  cluster-ca-certificate = "Get this value from eks console identified by 'Certificate authority'"
  chart-version          = "2.5.3"
  application-version    = "v1.7.3"
  environment            = "prod"
  project                = "sap
}
```
# Observation
Access https://github.com/kubernetes-sigs/aws-efs-csi-driver for verify the chart and application version available