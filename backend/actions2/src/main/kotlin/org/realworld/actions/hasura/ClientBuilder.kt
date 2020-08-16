package org.realworld.actions.hasura

import com.expediagroup.graphql.client.GraphQLClient
import io.ktor.client.HttpClientConfig
import io.ktor.client.engine.cio.CIO
import io.ktor.client.engine.cio.CIOEngineConfig
import io.ktor.client.features.defaultRequest
import io.ktor.client.request.header
import org.realworld.actions.Environment
import java.net.URL

typealias HasuraClient =
    GraphQLClient<CIOEngineConfig>

class ClientBuilder(environment: Environment) {
    private val url = environment.GRAPHQL_URL
    private val adminSecret = environment.ADMIN_SECRET

    fun build(): HasuraClient = GraphQLClient(
        url = URL(url),
        engineFactory = CIO,
        configuration = { configure() }
    )

    private fun HttpClientConfig<CIOEngineConfig>.configure() {
        defaultRequest { header("X-Hasura-Admin-Secret", adminSecret) }
    }
}