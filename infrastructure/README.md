# Realworld Infrastructure

![INFRA](https://github.com/andrewMacmurray/realworld-hasura/workflows/Infrastructure/badge.svg) 

Terraform configuration for provisioning infrastructure pieces for realworld app

### Pieces

+ The configuration manages 1 heroku instance (`actions server`) and 1 postgres database
+ Deployment of Docker image to the instance is handled separately

### Running plans and applies 

+ Terraform State and secrets for the project are stored in `Terraform Cloud` (https://app.terraform.io/app/andrewmacmurray/workspaces)
+ Terraform plans are run via a github actions workflow (`.github/workflows/infrastructure.yml`) - triggered on a PR to the `main` branch
+ Terraform auto apply is run on merge / push to `main` via github actions