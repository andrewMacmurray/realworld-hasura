package org.realworld.actions.hasura

import com.expediagroup.graphql.client.GraphQLClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.features.defaultRequest
import io.ktor.client.request.header
import java.net.URL

object Client {
    fun build() = GraphQLClient(
        url = URL("http://localhost:8080/v1/graphql"),
        engineFactory = CIO
    ) {
        defaultRequest {
            header("X-Hasura-Admin-Secret", "ilovebread")
        }
    }
}