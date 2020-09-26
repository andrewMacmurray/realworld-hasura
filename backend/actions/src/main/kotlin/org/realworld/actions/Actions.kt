package org.realworld.actions

import org.http4k.core.Filter
import org.http4k.core.Method.GET
import org.http4k.core.then
import org.http4k.filter.ServerFilters.CatchLensFailure
import org.http4k.routing.RoutingHttpHandler
import org.http4k.routing.bind
import org.http4k.routing.routes
import org.koin.core.KoinComponent
import org.koin.core.inject
import org.realworld.actions.articles.web.ArticlesController
import org.realworld.actions.auth.web.AuthController
import org.realworld.actions.utils.Result
import org.realworld.actions.web.AuthorizationFilter
import org.realworld.actions.web.Wakeup

typealias ActionResult<Output> =
        Result<String, Output>

interface Action<Input, Output> {
    fun process(input: Input): ActionResult<Output>
}

class Actions : KoinComponent {
    private val auth by inject<AuthController>()
    private val articles by inject<ArticlesController>()
    private val env by inject<Environment>()

    val handler: RoutingHttpHandler =
        routes(
            "/api" bind actionRoutes,
            "/wakeup" bind GET to Wakeup.handler
        )

    private val actionRoutes: RoutingHttpHandler
        get() = actionFilters().then(
            routes(
                auth.handler,
                articles.handler
            )
        )

    private fun actionFilters(): Filter =
        AuthorizationFilter(env.ACTIONS_SECRET)
            .then(CatchLensFailure())
}
