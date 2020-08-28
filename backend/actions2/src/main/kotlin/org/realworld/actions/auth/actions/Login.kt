package org.realworld.actions.auth.actions

import org.realworld.actions.Action
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.LoginRequest
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.PasswordError
import org.realworld.actions.auth.service.PasswordError.InvalidLogin
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.map
import org.realworld.actions.utils.mapError
import org.realworld.actions.utils.toResult

class Login(private val auth: Auth) : Action<LoginRequest, User.Login> {

    override fun process(input: LoginRequest): ActionResult<User.Login> =
        findUser(input.username)
            .andThen { checkPassword(input.password, it) }
            .andThen(::generateToken)

    private fun findUser(username: String): ActionResult<User> =
        auth.users
            .find(username)
            .toResult(InvalidLogin.message)

    private fun checkPassword(password: String, user: User): ActionResult<User> =
        auth.password
            .verify(password, user.passwordHash)
            .map { user }
            .mapError(PasswordError::message)

    private fun generateToken(user: User): ActionResult<User.Login> =
        auth.token
            .generate(user)
            .map { it.toLogin(user) }
            .mapError(TokenError::message)
}

private fun Token.toLogin(user: User) = User.Login(
    token = this,
    user = user
)