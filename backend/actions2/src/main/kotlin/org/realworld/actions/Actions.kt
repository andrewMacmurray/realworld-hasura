package org.realworld.actions

import org.http4k.routing.RoutingHttpHandler
import org.realworld.actions.auth.AuthActions
import org.realworld.actions.auth.AuthComponents
import org.realworld.actions.auth.AuthController
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe

interface Action<Input, Output> {
    fun process(input: Input): Result<String, Output>
}

object Actions {
    val handle: RoutingHttpHandler =
        AuthComponents()
            .pipe { AuthActions(it) }
            .pipe { AuthController(it).handle }
}

