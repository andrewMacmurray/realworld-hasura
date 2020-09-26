locals {
  actions_api_name = "realworld-actions"
  actions_api_url  = "https://${local.actions_api_name}.herokuapp.com"
}

resource "heroku_app" "actions" {
  name                  = local.actions_api_name
  region                = "eu"
  stack                 = "container"
  sensitive_config_vars = {
    ACTIONS_SECRET              = random_password.actions_secret.result
    HASURA_GRAPHQL_URL          = local.hasura_app_graphql_url
    HASURA_GRAPHQL_ADMIN_SECRET = random_password.admin_secret.result
    HASURA_GRAPHQL_JWT_SECRET   = random_password.jwt_secret.result
  }
}