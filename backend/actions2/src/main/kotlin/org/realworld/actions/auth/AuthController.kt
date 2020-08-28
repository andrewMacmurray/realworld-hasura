package org.realworld.actions.auth

import org.http4k.core.Method.POST
import org.http4k.routing.bind
import org.http4k.routing.routes
import org.realworld.actions.ActionResult
import org.realworld.actions.utils.map
import org.realworld.actions.web.Action
import org.realworld.actions.web.Controller

class AuthController(private val actions: AuthActions) : Controller {

    override val handle = routes(
        "/signup" bind POST to Action.handle(::signup),
        "/login" bind POST to Action.handle(::login)
    )

    private fun login(request: LoginRequest): ActionResult<LoginResponse> =
        actions.login
            .process(request)
            .map(User.Login::toLoginResponse)

    private fun signup(request: SignupRequest): ActionResult<SignupResponse> =
        actions.signup
            .process(request)
            .map(request::toSignupResponse)
}

