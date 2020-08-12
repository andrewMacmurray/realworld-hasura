package org.realworld.actions.auth

import org.realworld.actions.auth.service.PasswordError
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.auth.service.User
import org.realworld.actions.pipe
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.map
import org.realworld.actions.utils.mapError

class Signup(private val auth: Auth) {
    fun process(request: SignupRequest): Result<String, Token> =
        request.password
            .pipe(::hashPassword)
            .map(request::toUser)
            .map(auth.users::create)
            .andThen(::generateToken)

    private fun hashPassword(pw: String): Result<String, String> =
        auth.password.hash(pw).mapError(PasswordError::message)

    private fun generateToken(user: User): Result<String, Token> =
        auth.token.generate(user).mapError(TokenError::message)
}

class SignupRequest(
    val username: String,
    val email: String,
    val password: String
)

private fun SignupRequest.toUser(hash: String) = User.ToCreate(
    username = this.username,
    email = this.email,
    passwordHash = hash
)

