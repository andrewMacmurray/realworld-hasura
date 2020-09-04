package org.realworld.actions.auth.actions

import org.realworld.actions.Action
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.PasswordError
import org.realworld.actions.auth.service.PasswordError.InvalidLogin
import org.realworld.actions.auth.service.Token
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.map
import org.realworld.actions.utils.mapError
import org.realworld.actions.utils.toResult

class Login(private val auth: Auth) : Action<Login.Input, User.Login> {

    interface Input {
        val username: String
        val password: String
    }

    override fun process(input: Input): ActionResult<User.Login> =
        findUser(input.username)
            .andThen { checkPassword(input.password, it) }
            .map(::generateToken)

    private fun findUser(username: String): ActionResult<User> =
        auth.users
            .find(username)
            .toResult(InvalidLogin.message)

    private fun checkPassword(password: String, user: User): ActionResult<User> =
        auth.password
            .verify(password, user.passwordHash)
            .map { user }
            .mapError(PasswordError::message)

    private fun generateToken(user: User): User.Login =
        auth.token.generate(user).toLogin(user)
}

private fun Token.toLogin(user: User) = User.Login(
    token = this,
    user = user
)