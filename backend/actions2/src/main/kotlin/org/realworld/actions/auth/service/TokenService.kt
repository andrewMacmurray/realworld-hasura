package org.realworld.actions.auth.service

import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.jsonwebtoken.Claims
import io.jsonwebtoken.JwtException
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.io.Serializer
import io.jsonwebtoken.jackson.io.JacksonSerializer
import io.jsonwebtoken.security.Keys
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.TokenError.CreateFailed
import org.realworld.actions.auth.service.TokenError.InvalidToken
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.Result.Err
import org.realworld.actions.utils.Result.Ok
import org.realworld.actions.utils.pipe
import java.nio.charset.StandardCharsets
import javax.crypto.SecretKey

// Token

data class Token(val userId: Int, val value: String) {
    data class Decoded(
        val username: String,
        val email: String,
        val permissions: String
    )
}

// Tokens

interface TokenService {
    fun generate(user: User): Result<TokenError, Token>
    fun decode(token: Token): Result<TokenError, Token.Decoded>
}

// JWT

class HasuraTokens(secret: String) : TokenService {

    private val key: SecretKey =
        StandardCharsets.UTF_8
            .pipe(secret::toByteArray)
            .pipe(Keys::hmacShaKeyFor)

    override fun generate(user: User): Result<TokenError, Token> = try {
        createToken(user)
    } catch (e: JwtException) {
        Err(CreateFailed)
    }

    private fun createToken(user: User): Result<TokenError, Token> =
        Jwts.builder()
            .claim("username", user.username)
            .claim("email", user.email)
            .claim(Hasura.namespace, Hasura.Claims(user))
            .serializeToJsonWith(serializer)
            .signWith(key)
            .compact()
            .pipe { Token(user.id, it) }
            .pipe(::Ok)

    override fun decode(token: Token): Result<TokenError, Token.Decoded> = try {
        Jwts.parserBuilder()
            .setSigningKey(key)
            .build()
            .parseClaimsJws(token.value)
            .pipe { toDecoded(it.body) }
            .pipe(::Ok)
    } catch (e: JwtException) {
        Err(InvalidToken)
    }

    private val serializer: Serializer<Map<String, *>> =
        JacksonSerializer(jacksonObjectMapper())

    private fun toDecoded(claims: Claims) = Token.Decoded(
        username = claims["username"].toString(),
        email = claims["email"].toString(),
        permissions = claims[Hasura.namespace].toString()
    )
}

object Hasura {
    const val namespace: String =
        "https://hasura.io/jwt/claims"

    data class Claims(
        private val user: User,

        @JsonProperty("x-hasura-allowed-roles")
        val allowedRoles: List<String> = listOf("user"),

        @JsonProperty("x-hasura-default-role")
        val defaultRole: String = "user"
    ) {
        @JsonProperty("x-hasura-user-id")
        val userId: String = "${user.id}"
    }
}

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