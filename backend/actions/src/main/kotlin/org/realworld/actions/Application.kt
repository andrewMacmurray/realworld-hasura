package org.realworld.actions

import org.http4k.core.HttpHandler
import org.http4k.serverless.AppLoader
import org.realworld.actions.utils.pipe
import org.realworld.actions.web.DevServer

fun main() {
    DevServer.listenOn(4000, Application.handler)
}

object Application : AppLoader {
    override fun invoke(p1: Map<String, String>): HttpHandler =
        handler

    val handler: HttpHandler =
        Context.create().pipe { Actions().handler }
}