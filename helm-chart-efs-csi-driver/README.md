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

module "helm-chart-efs-csi-driver" {
  source                 = "./helm-chart-efs-csi-driver"
  cluster-name           = module.eks.cluster-name
  api-server-endpoint    = module.eks.api-server-endpoint
  cluster-ca-certificate = module.eks.cluster-ca-certificate
  oidc-provider-arn      = module.eks.oidc-provider-arn
  cluster-oidc-url       = module.eks.cluster-oidc-url
  namespace              = "kube-system"
  project                = "sap"
  environment            = "prod"
  chart-version          = "2.5.6"
  application-version    = "v1.7.6"
}
```