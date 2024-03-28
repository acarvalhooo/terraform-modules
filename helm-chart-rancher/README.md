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

module "helm-chart-rancher" {
  source                 = "./terraform-modules/helm-chart-rancher"
  cluster-name           = module.eks.cluster-name
  api-server-endpoint    = module.eks.api-server-endpoint
  cluster-ca-certificate = module.eks.cluster-ca-certificate
  namespace              = "cattle-system"
  ingress-class          = "nginx"
  hostname               = "rancher.companyname.com"
  replicas               = "2"
}
```