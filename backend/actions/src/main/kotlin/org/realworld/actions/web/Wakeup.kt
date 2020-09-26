package org.realworld.actions.web

import org.http4k.core.*
import org.http4k.filter.CorsPolicy
import org.http4k.filter.ServerFilters

object Wakeup {
    private val withCors: Filter =
        ServerFilters.Cors(CorsPolicy.UnsafeGlobalPermissive)

    val handler: HttpHandler =
        withCors.then { Response(Status.OK) }
}