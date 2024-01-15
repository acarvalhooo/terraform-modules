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

module "smb-csi-driver" {
  source                 = "./smb-csi-driver"
  cluster-oidc-url       = "https://oidc.eks.us-east-1.amazonaws.com/id/A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0"
  cluster-name           = "eks-cluster-sap-prod"
  endpoint               = "https://A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0.A0A.us-east-1.eks.amazonaws.com"
  cluster-ca-certificate = "Get this value from eks console identified by 'Certificate authority'"
  chart-version          = "v1.13.0"
  environment            = "prod"
  project                = "sap"
}
```
# Observation
Access https://github.com/kubernetes-csi/csi-driver-smb/tree/master/charts for verify the chart version available