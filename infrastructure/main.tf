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

resource "heroku_app" "hasura" {
  name = "realworld-hasura"
  stack = "container"
  region = "eu"
  sensitive_config_vars = {
    HASURA_GRAPHQL_ADMIN_SECRET = random_password.admin_secret.result
    HASURA_GRAPHQL_JWT_SECRET = local.hasura_jwt_secret
    ACTIONS_SECRET = random_password.actions_secret.result
  }
  config_vars = {
    HASURA_GRAPHQL_ENABLE_CONSOLE = true
    HASURA_GRAPHQL_UNAUTHORIZED_ROLE = "anonymous"
    ACTIONS_BASE_URL = "http://localhost:4000"
  }
}

resource "heroku_build" "hasura" {
  app = heroku_app.hasura.name
  source = {
    path = "../backend/hasura/"
  }
}

resource "heroku_addon" "hasura_db" {
  app = heroku_app.hasura.name
  plan = "heroku-postgresql:hobby-dev"
}
