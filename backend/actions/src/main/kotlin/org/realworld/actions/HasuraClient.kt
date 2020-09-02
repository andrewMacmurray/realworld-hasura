package org.realworld.actions

import com.expediagroup.graphql.client.GraphQLClient
import io.ktor.client.HttpClientConfig
import io.ktor.client.engine.cio.CIO
import io.ktor.client.engine.cio.CIOEngineConfig
import io.ktor.client.features.defaultRequest
import io.ktor.client.request.header
import java.net.URL

typealias HasuraClient =
        GraphQLClient<CIOEngineConfig>

class ClientBuilder(private val env: Environment) {

    fun build(): HasuraClient = GraphQLClient(
        url = URL(env.GRAPHQL_URL),
        engineFactory = CIO,
        configuration = { configure() }
    )

    private fun HttpClientConfig<CIOEngineConfig>.configure() {
        defaultRequest { header("X-Hasura-Admin-Secret", env.ADMIN_SECRET) }
    }
}