package org.realworld.actions

object Environment {
    val HASURA_JWT_SECRET = System.getenv("HASURA_JWT_SECRET")!!
    val HASURA_ADMIN_SECRET = System.getenv("HASURA_ADMIN_SECRET")!!
    val HASURA_GRAPHQL_URL = System.getenv("HASURA_GRAPHQL_URL")!!
}