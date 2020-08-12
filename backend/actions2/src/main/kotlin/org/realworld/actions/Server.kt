package org.realworld.actions

import org.http4k.core.HttpHandler
import org.http4k.serverless.AppLoader
import org.realworld.actions.utils.DevServer

fun main() {
    DevServer.start(4000, Actions.handler)
}

object LambdaServer : AppLoader {
    override fun invoke(p1: Map<String, String>): HttpHandler =
        Actions.handler
}