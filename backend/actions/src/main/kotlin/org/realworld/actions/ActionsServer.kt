package org.realworld.actions

import org.http4k.core.Filter
import org.http4k.core.then
import org.http4k.filter.ServerFilters.CatchLensFailure
import org.http4k.routing.RoutingHttpHandler
import org.http4k.routing.routes
import org.koin.core.KoinComponent
import org.koin.core.inject
import org.realworld.actions.articles.web.ArticlesController
import org.realworld.actions.auth.web.AuthController
import org.realworld.actions.utils.Result
import org.realworld.actions.web.AuthorizationFilter
import org.realworld.actions.web.LogFilter

typealias ActionResult<Output> =
        Result<String, Output>

interface Action<Input, Output> {
    fun process(input: Input): ActionResult<Output>
}

class ActionsServer : KoinComponent {
    private val auth by inject<AuthController>()
    private val articles by inject<ArticlesController>()
    private val env by inject<Environment>()

    val handler: RoutingHttpHandler =
        buildFilters().then(routes)

    private val routes: RoutingHttpHandler
        get() = routes(
            auth.handler,
            articles.handler
        )

    private fun buildFilters(): Filter =
        AuthorizationFilter(env.ACTIONS_SECRET)
            .then(LogFilter())
            .then(CatchLensFailure())
}
