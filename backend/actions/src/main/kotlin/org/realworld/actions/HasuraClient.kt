package org.realworld.actions

import com.expediagroup.graphql.client.GraphQLKtorClient
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.ktor.client.*
import io.ktor.client.engine.okhttp.*
import io.ktor.client.features.*
import io.ktor.client.features.logging.*
import io.ktor.client.request.*
import java.net.URL

typealias HasuraClient =
        GraphQLKtorClient<OkHttpConfig>

class ClientBuilder(private val env: Environment) {

    fun build(): HasuraClient = GraphQLKtorClient(
        url = URL(env.GRAPHQL_URL),
        mapper = jacksonObjectMapper(),
        engineFactory = OkHttp,
        configuration = { configure() }
    )

    private fun HttpClientConfig<OkHttpConfig>.configure() {
        defaultRequest { header("X-Hasura-Admin-Secret", env.ADMIN_SECRET) }
        install(Logging) {
            logger = Logger.DEFAULT
            level = LogLevel.BODY
        }
    }
}