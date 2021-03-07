terraform {
  backend "remote" {
    organization = "andrewmacmurray"

    workspaces {
      name = "realworld-hasura"
    }
  }
}

provider "heroku" {
  version = "~> 2.6.1"
}

provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

provider "github" {
  owner = "andrewMacmurray"
}
