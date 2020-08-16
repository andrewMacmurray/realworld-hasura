package org.realworld.actions.auth

import org.http4k.core.Method.POST
import org.http4k.routing.bind
import org.http4k.routing.routes
import org.realworld.actions.auth.service.Token
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.map
import org.realworld.actions.web.Controller
import org.realworld.actions.web.lambdaHandler

class AuthController(private val signup: Signup) : Controller {

    override val handle = routes(
        "/signup" bind POST to lambdaHandler(::signup)
    )

    private fun signup(request: SignupRequest): Result<String, SignupResponse> {
        return signup
            .process(request)
            .map(request::toSignupResponse)
    }
}

private fun SignupRequest.toSignupResponse(token: Token) = SignupResponse(
    token = token.value,
    user_id = token.userId,
    username = this.username,
    email = this.email,
    bio = null,
    profile_image = null
)

data class SignupResponse(
    val token: String,
    val user_id: Int,
    val username: String,
    val email: String,
    val bio: String?,
    val profile_image: String?
)

data class SignupRequest(
    val username: String,
    val email: String,
    val password: String
)
