package org.realworld.actions.web

import org.http4k.routing.RoutingHttpHandler

interface Controller {
    val handle: RoutingHttpHandler
}