package org.realworld.actions.utils

import org.http4k.core.HttpHandler
import org.http4k.server.Jetty
import org.http4k.server.asServer

object Server {
    fun listenOn(port: Int, handler: HttpHandler) {
        handler
            .asServer(Jetty(port))
            .start()
            .block()
    }
}