package org.realworld.actions.auth.service

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.auth0.jwt.exceptions.JWTCreationException
import com.auth0.jwt.exceptions.JWTDecodeException
import com.auth0.jwt.interfaces.DecodedJWT
import com.fasterxml.jackson.annotation.JsonProperty
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.TokenError.CreateFailed
import org.realworld.actions.auth.service.TokenError.InvalidToken
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.Result.Err
import org.realworld.actions.utils.Result.Ok
import org.realworld.actions.utils.pipe

// Token

data class Token(
    val userId: Int,
    val value: String
)

// Tokens

interface TokenService {
    fun generate(user: User): Result<TokenError, Token>
    fun decode(token: Token): Result<TokenError, DecodedJWT>
}

// JWT

class HasuraTokens(secret: String) : TokenService {

    private val algorithm: Algorithm =
        Algorithm.HMAC256(secret)

    private val namespace: String =
        "https://hasura.io/jwt/claims"

    override fun generate(user: User): Result<TokenError, Token> = try {
        createToken(user)
    } catch (e: JWTCreationException) {
        Err(CreateFailed)
    }

    private fun createToken(user: User): Result<TokenError, Token> =
        JWT.create()
            .withClaim("username", user.username)
            .withClaim("email", user.email)
            .withClaim(namespace, hasuraClaims(user))
            .sign(algorithm)
            .pipe { Token(user.id, it) }
            .pipe(::Ok)

    private fun hasuraClaims(user: User): String = """
        {
          "x-hasura-allowed-roles": ["user"],
          "x-hasura-default-role": "user",
          "x-hasura-user-id": ${user.id}
        }
    """

    override fun decode(token: Token): Result<TokenError, DecodedJWT> = try {
        JWT.decode(token.value).pipe(::Ok)
    } catch (e: JWTDecodeException) {
        Err(InvalidToken)
    }
}

data class HasuraClaims(
    @JsonProperty("x-hasura-allowed-roles")
    val allowedRoles: List<String> = listOf("user"),

    @JsonProperty("x-hasura-default-role")
    val defaultRole: String = "user",

    @JsonProperty("x-hasura-user-id")
    val userId: Int
)

// Errors

sealed class TokenError {
    abstract val message: String

    object CreateFailed : TokenError() {
        override val message: String = "Could not create token"
    }

    object InvalidToken : TokenError() {
        override val message: String = "Token is invalid"
    }
}