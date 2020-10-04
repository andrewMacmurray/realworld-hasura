package org.realworld.actions.auth.actions

import org.realworld.actions.Action
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.User
import org.realworld.actions.auth.UsersError
import org.realworld.actions.auth.service.PasswordError
import org.realworld.actions.auth.service.Token
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.map
import org.realworld.actions.utils.mapError

class Signup(private val auth: Auth) : Action<Signup.Input, Token> {

    interface Input {
        val username: String
        val email: String
        val password: String
    }

    override fun process(input: Input): ActionResult<Token> =
        hashPassword(input.password)
            .map(input::toUser)
            .andThen(::createUser)
            .map(::generateToken)

    private fun createUser(user: User.ToCreate): ActionResult<User> =
        user.validate()
            .andThen { auth.users.create(it) }
            .mapError(UsersError::message)

    private fun hashPassword(pw: String): ActionResult<String> =
        auth.password.hash(pw).mapError(PasswordError::message)

    private fun generateToken(user: User): Token =
        auth.token.generate(user)
}

private fun Signup.Input.toUser(hash: String) =
    User.ToCreate(
        username = this.username,
        email = this.email,
        passwordHash = hash
    )