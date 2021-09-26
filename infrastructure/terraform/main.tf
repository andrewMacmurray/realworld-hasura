terraform {
  backend "remote" {
    organization = "andrewmacmurray"

    workspaces {
      name = "realworld-hasura"
    }
  }
}

provider "heroku" {}

provider "github" {}
