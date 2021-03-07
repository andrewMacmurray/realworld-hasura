locals {
  actions_server_url = "https://realworld-hasura.vercel.app/api"
  hasura_db_url      = "postgres://${aws_db_instance.hasura-db.username}:${aws_db_instance.hasura-db.password}@${aws_db_instance.hasura-db.endpoint}/hasura"
}

resource "heroku_app" "hasura" {
  name                  = "realworld-hasura"
  region                = "eu"
  stack                 = "container"
  config_vars           = {
    HASURA_GRAPHQL_UNAUTHORIZED_ROLE = "anonymous"
    HASURA_GRAPHQL_ENABLE_CONSOLE    = true
    ACTIONS_BASE_URL                 = local.actions_server_url
  }
  sensitive_config_vars = {
    ACTIONS_SECRET              = random_password.actions_secret.result
    DATABASE_URL                = local.hasura_db_url
    HASURA_GRAPHQL_ADMIN_SECRET = random_password.admin_secret.result
    HASURA_GRAPHQL_JWT_SECRET   = jsonencode({
      key  = random_password.jwt_secret.result,
      type = "HS256"
    })
  }
}
