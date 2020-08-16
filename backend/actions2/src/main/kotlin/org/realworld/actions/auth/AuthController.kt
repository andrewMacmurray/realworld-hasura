package org.realworld.actions.auth

import org.http4k.core.Method.POST
import org.http4k.routing.bind
import org.http4k.routing.routes
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.map
import org.realworld.actions.web.Controller
import org.realworld.actions.web.lambdaHandler

class AuthController(private val actions: AuthActions) : Controller {

    override val handle = routes(
        "/signup" bind POST to lambdaHandler(::signup),
        "/login" bind POST to lambdaHandler(::login)
    )

    private fun login(request: LoginRequest): Result<String, LoginResponse> =
        actions.login
            .process(request)
            .map(User.Login::toLoginResponse)

    private fun signup(request: SignupRequest): Result<String, SignupResponse> =
        actions.signup
            .process(request)
            .map(request::toSignupResponse)
}

