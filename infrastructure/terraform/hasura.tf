locals {
  hasura_app_name          = "realworld-hasura"
  hasura_app_graphql_url   = "https://${local.hasura_app_name}.herokuapp.com/v1/graphql"
  hasura_unauthorized_role = "anonymous"
  hasura_jwt_secret        = jsonencode({
    type = "HS256"
    key  = random_password.jwt_secret.result
  })
}

resource "heroku_app" "hasura" {
  name                  = local.hasura_app_name
  stack                 = "container"
  region                = "eu"
  sensitive_config_vars = {
    HASURA_GRAPHQL_ADMIN_SECRET = random_password.admin_secret.result
    HASURA_GRAPHQL_JWT_SECRET   = local.hasura_jwt_secret
    ACTIONS_SECRET              = random_password.actions_secret.result
  }
  config_vars           = {
    HASURA_GRAPHQL_ENABLE_CONSOLE    = true
    HASURA_GRAPHQL_UNAUTHORIZED_ROLE = local.hasura_unauthorized_role
    ACTIONS_BASE_URL                 = local.actions_api_url
  }
}

resource "heroku_addon" "hasura_db" {
  app  = heroku_app.hasura.name
  plan = "heroku-postgresql:hobby-dev"
}
