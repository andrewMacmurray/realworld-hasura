package org.realworld.actions.web

import org.http4k.core.Filter
import org.http4k.core.HttpHandler
import org.http4k.core.Request
import org.http4k.routing.RoutingHttpHandler

interface Controller {
    val handler: RoutingHttpHandler
}

