package org.realworld.actions.auth.service

import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.User
import org.realworld.actions.utils.pipe

class TokenServiceTest {

    private val tokens: HasuraTokens =
        hasuraTokens()

    @Test
    fun `generates a JWT with username and email claims`() {
        val details = userDetails()
        tokens
            .generate(details)
            .pipe(::decodeToken)
            .pipe {
                assertEquals(details.username, it.username)
                assertEquals(details.email, it.email)
            }
    }

    @Test
    fun `generates a JWT with hasura claims`() {
        val details = userDetails()
        tokens
            .generate(details)
            .pipe(::decodeToken)
            .pipe {
                assertTrue(it.permissions.contains("${details.id}"))
            }
    }

    private fun decodeToken(token: Token): Decoded =
        Jwts.parserBuilder()
            .setSigningKey(tokens.key)
            .build()
            .parseClaimsJws(token.value)
            .pipe { toDecoded(it.body) }

    private fun toDecoded(claims: Claims) = Decoded(
        username = claims["username"].toString(),
        email = claims["email"].toString(),
        permissions = claims[Hasura.namespace].toString()
    )

    data class Decoded(
        val username: String,
        val email: String,
        val permissions: String
    )

    private fun hasuraTokens() =
        HasuraTokens("PTClNSJGXLA90wjPjzoz3hJCabHR8U16w")

    private fun userDetails() = User(
        id = 1,
        username = "andrew",
        email = "a@b.com",
        passwordHash = "password_hash",
        bio = "about me",
        profileImage = "http://bread.png"
    )
}