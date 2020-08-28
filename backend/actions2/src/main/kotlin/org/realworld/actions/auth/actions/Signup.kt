package org.realworld.actions.auth.actions

import org.realworld.actions.Action
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.SignupRequest
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.PasswordError
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.auth.service.UsersError
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.map
import org.realworld.actions.utils.mapError

class Signup(private val auth: Auth) : Action<SignupRequest, Token> {

    override fun process(input: SignupRequest): ActionResult<Token> =
        hashPassword(input.password)
            .map(input::toUser)
            .andThen(::createUser)
            .andThen(::generateToken)

    private fun createUser(user: User.ToCreate): ActionResult<User> =
        auth.users.create(user).mapError(UsersError::message)

    private fun hashPassword(pw: String): ActionResult<String> =
        auth.password.hash(pw).mapError(PasswordError::message)

    private fun generateToken(user: User): ActionResult<Token> =
        auth.token.generate(user).mapError(TokenError::message)
}

private fun SignupRequest.toUser(hash: String) =
    User.ToCreate(
        username = this.username,
        email = this.email,
        passwordHash = hash
    )