package org.realworld.actions.auth

import org.realworld.actions.auth.service.PasswordError
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.auth.service.UsersError
import org.realworld.actions.utils.*

class Signup(private val auth: Auth) {
    fun process(request: SignupRequest): Result<String, Token> =
        request.password
            .pipe(::hashPassword)
            .map(request::toUser)
            .andThen(::createUser)
            .andThen(::generateToken)

    private fun createUser(user: User.ToCreate): Result<String, User> =
        auth.users.create(user).mapError(UsersError::message)

    private fun hashPassword(pw: String): Result<String, String> =
        auth.password.hash(pw).mapError(PasswordError::message)

    private fun generateToken(user: User): Result<String, Token> =
        auth.token.generate(user).mapError(TokenError::message)
}

private fun SignupRequest.toUser(hash: String) = User.ToCreate(
    username = this.username,
    email = this.email,
    passwordHash = hash
)

