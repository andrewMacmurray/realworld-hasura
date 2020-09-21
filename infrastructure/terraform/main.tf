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
  region = "eu-west-1"
}