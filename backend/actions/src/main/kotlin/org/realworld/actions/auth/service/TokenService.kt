package org.realworld.actions.auth.service

import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.io.Serializer
import io.jsonwebtoken.jackson.io.JacksonSerializer
import io.jsonwebtoken.security.Keys
import org.realworld.actions.auth.User
import org.realworld.actions.utils.pipe
import java.nio.charset.StandardCharsets
import javax.crypto.SecretKey

// Token

data class Token(
    val userId: Int,
    val value: String
)

// Tokens

interface TokenService {
    fun generate(user: User): Token
}

// JWT

class HasuraTokens(secret: String) : TokenService {

    val key: SecretKey =
        StandardCharsets.UTF_8
            .pipe(secret::toByteArray)
            .pipe(Keys::hmacShaKeyFor)

    override fun generate(user: User): Token =
        Jwts.builder()
            .claim("username", user.username)
            .claim("email", user.email)
            .claim(Hasura.namespace, Hasura.Claims(user))
            .serializeToJsonWith(serializer)
            .signWith(key)
            .compact()
            .pipe { Token(user.id, it) }

    private val serializer: Serializer<Map<String, *>> =
        JacksonSerializer(jacksonObjectMapper())
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