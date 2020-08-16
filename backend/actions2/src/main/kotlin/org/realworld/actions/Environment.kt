package org.realworld.actions

object Environment {
    val JWT_SECRET = System.getenv("HASURA_GRAPHQL_JWT_SECRET")!!
    val ADMIN_SECRET = System.getenv("HASURA_GRAPHQL_ADMIN_SECRET")!!
    val GRAPHQL_URL = System.getenv("HASURA_GRAPHQL_URL")!!
}