package org.realworld.actions

import org.http4k.core.HttpHandler
import org.http4k.serverless.AppLoader
import org.realworld.actions.utils.DevServer

fun main() {
    DevServer.start(4000, Actions.handle)
}

object Application : AppLoader {
    override fun invoke(p1: Map<String, String>): HttpHandler =
        Actions.handle
}