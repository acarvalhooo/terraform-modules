# Terraform-Modules
This repository was created to store Terraform modules.

## Providers and versions used
1. hashicorp/aws in version 5.23.1

2. hashicorp/helm in version 2.11.0

## Observations
1. Some resources need a value that must be passed via orchestrator or just inserting a default value in variable

2. Before you just apply the code, review some informations like key administrator arn in key policy or any other thing