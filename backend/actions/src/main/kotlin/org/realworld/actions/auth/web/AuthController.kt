package org.realworld.actions.auth.web

import org.http4k.core.Method.POST
import org.http4k.routing.bind
import org.http4k.routing.routes
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.User
import org.realworld.actions.utils.map
import org.realworld.actions.web.Controller
import org.realworld.actions.web.Handler

class AuthController(private val actions: Auth.Actions) : Controller {

    override val handler = routes(
        "/signup" bind POST to Handler(::signup),
        "/login" bind POST to Handler(::login)
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

