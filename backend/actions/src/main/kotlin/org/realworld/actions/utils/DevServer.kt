package org.realworld.actions.utils

import org.http4k.core.HttpHandler
import org.http4k.server.SunHttp
import org.http4k.server.asServer

object DevServer {
    fun listenOn(port: Int, handler: HttpHandler) {
        println("starting local server on $port")
        handler
            .asServer(SunHttp(port))
            .start()
    }
}