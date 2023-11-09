# Terraform-Modules
This repository was created to store Terraform modules.

## Providers and versions used
1. Terraform version is 1.6.2

2. hashicorp/aws in version 5.23.1

3. hashicorp/helm in version 2.11.0

## Observations
1. Some resources need a value that must be passed via orchestrator or just inserting a default value in variable

2. Before you just apply the code, review some informations like key administrator arn in key policy or any other thing