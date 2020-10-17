locals {
  hasura_app_name        = "realworld-hasura-db"
  hasura_app_graphql_url = "https://trusty-mastodon-93.hasura.app/v1/graphql"
}

resource "heroku_app" "hasura" {
  name   = local.hasura_app_name
  region = "eu"
}

resource "heroku_addon" "hasura_db" {
  app  = heroku_app.hasura.name
  plan = "heroku-postgresql:hobby-dev"
}
