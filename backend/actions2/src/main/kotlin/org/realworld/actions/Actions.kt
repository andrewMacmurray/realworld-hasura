package org.realworld.actions

import org.http4k.routing.RoutingHttpHandler
import org.realworld.actions.auth.AuthController
import org.realworld.actions.auth.AuthComponents
import org.realworld.actions.auth.Signup

object Actions {
    private val auth = AuthComponents()
    private val signup = Signup(auth)

    val handle: RoutingHttpHandler =
        AuthController(signup).handle
}

