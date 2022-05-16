locals {
  repository = "andrewMacmurray/realworld-hasura"
}

resource "github_actions_secret" "jwt_secret" {
  plaintext_value = random_password.jwt_secret.result
  repository      = local.repository
  secret_name     = "HASURA_GRAPHQL_JWT_SECRET"
}

resource "github_actions_secret" "admin_secret" {
  plaintext_value = random_password.admin_secret.result
  repository      = local.repository
  secret_name     = "HASURA_GRAPHQL_ADMIN_SECRET"
}

resource "github_actions_secret" "actions_secret" {
  plaintext_value = random_password.actions_secret.result
  repository      = local.repository
  secret_name     = "HASURA_ACTIONS_SECRET"
}

resource "github_actions_secret" "graphql_url" {
  plaintext_value = local.hasura_graphql_url
  repository      = local.repository
  secret_name     = "HASURA_GRAPHQL_URL"
}

resource "github_actions_secret" "hasura_endpoint" {
  plaintext_value = local.hasura_url
  repository      = local.repository
  secret_name     = "HASURA_ENDPOINT"
}

resource "github_actions_secret" "hasura_health_check" {
  plaintext_value = local.hasura_health_check
  repository      = local.repository
  secret_name     = "HASURA_HEALTH_CHECK_NEW"
}
