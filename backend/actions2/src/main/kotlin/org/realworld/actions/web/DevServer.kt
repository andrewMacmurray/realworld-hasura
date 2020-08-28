package org.realworld.actions.web

import org.http4k.core.Filter
import org.http4k.core.HttpHandler
import org.http4k.core.then
import org.http4k.filter.RequestFilters
import org.http4k.filter.ResponseFilters
import org.http4k.filter.ServerFilters.CatchLensFailure
import org.http4k.server.SunHttp
import org.http4k.server.asServer

object DevServer {
    fun start(port: Int, handler: HttpHandler) {
        println("starting local server on $port")
        DebugFilter()
            .then(CatchLensFailure())
            .then(handler)
            .asServer(SunHttp(port))
            .start()
    }
}

private object DebugFilter {
    operator fun invoke(): Filter =
        logRequest().then(logResponse())

    private fun logRequest(): Filter =
        RequestFilters.Tap { print("${it.method} ${it.uri}") }

    private fun logResponse(): Filter =
        ResponseFilters.Tap { println(" -- ${it.status}") }
}
