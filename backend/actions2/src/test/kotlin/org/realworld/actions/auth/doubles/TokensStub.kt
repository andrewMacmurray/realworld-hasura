package org.realworld.actions.auth.doubles

import com.auth0.jwt.interfaces.DecodedJWT
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.auth.service.TokenService
import org.realworld.actions.utils.Result

class TokensStub(private val token: String) : TokenService {
    override fun generate(user: User): Result<TokenError, Token> =
        Result.Ok(Token(user.id, token))

    override fun decode(token: Token): Result<TokenError, DecodedJWT> {
        TODO("Not yet implemented")
    }
}