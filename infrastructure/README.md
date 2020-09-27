# Realworld Infrastructure

![INFRA](https://github.com/andrewMacmurray/realworld-hasura/workflows/Infrastructure/badge.svg) 

Terraform configuration for provisioning infrastructure pieces for realworld app

### Pieces

+ The configuration manages 2 heroku instances (`hasura` + `actions server`) and 1 postgres database
+ Deployment of Docker images to the instances is handled separately

### Running plans and applies 

+ Terraform State and secrets for the project are stored in `Terraform Cloud` (https://app.terraform.io/app/andrewmacmurray/workspaces)
+ Terraform plans are run via a github actions workflow (`.github/workflows/infrastructure.yml`) - triggered on a PR to the `main` branch
+ Terraform auto apply is run on merge / push to `main` via github actions