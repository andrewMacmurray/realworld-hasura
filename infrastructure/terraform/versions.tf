terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
    }
    random = {
      source = "hashicorp/random"
    }
    github = {
      source = "integrations/github"
    }
  }
  required_version = ">= 0.13"
}
