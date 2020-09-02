package org.realworld.actions.auth.doubles

import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenService

class TokensStub(val token: String) : TokenService {
    override fun generate(user: User) = Token(
        userId = user.id,
        value = token
    )
}