package org.realworld.actions.auth

import org.http4k.core.Method.POST
import org.http4k.routing.bind
import org.http4k.routing.routes
import org.realworld.actions.auth.service.Token
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.map
import org.realworld.actions.web.Controller
import org.realworld.actions.web.jsonHandler

class AuthController(private val signup: Signup) : Controller {

    override val handle = routes(
        "/signup" bind POST to jsonHandler(::signup)
    )

    private fun signup(request: SignupRequest): Result<String, SignupResponse> =
        signup
            .process(request)
            .map(::SignupResponse)
}

data class SignupResponse(val token: Token)

data class SignupRequest(
    val username: String,
    val email: String,
    val password: String
)
