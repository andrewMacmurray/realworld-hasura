package org.realworld.actions

import org.http4k.routing.routes
import org.koin.core.KoinComponent
import org.koin.core.inject
import org.realworld.actions.articles.ArticlesController
import org.realworld.actions.auth.AuthController
import org.realworld.actions.utils.Result

typealias ActionResult<Output> =
        Result<String, Output>

interface Action<Input, Output> {
    fun process(input: Input): ActionResult<Output>
}

class Actions : KoinComponent {
    private val auth by inject<AuthController>()
    private val articles by inject<ArticlesController>()

    val handler = routes(
        auth.handler,
        articles.handler
    )
}
