package org.realworld.actions

import org.http4k.routing.routes
import org.realworld.actions.articles.ArticlesActions
import org.realworld.actions.articles.ArticlesComponents
import org.realworld.actions.articles.ArticlesController
import org.realworld.actions.auth.AuthActions
import org.realworld.actions.auth.AuthComponents
import org.realworld.actions.auth.AuthController
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe

typealias ActionResult<Output> =
        Result<String, Output>

interface Action<Input, Output> {
    fun process(input: Input): ActionResult<Output>
}

class Components {
    private val env = Environment
    private val client = ClientBuilder(env).build()

    val auth =
        AuthComponents(client, env)
            .pipe(::AuthActions)
            .pipe(::AuthController)

    val articles =
        ArticlesComponents(client)
            .pipe(::ArticlesActions)
            .pipe(::ArticlesController)
}

object Actions {
    private val components = Components()

    val handle = routes(
        components.auth.handle,
        components.articles.handle
    )
}

