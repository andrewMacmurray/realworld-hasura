package org.realworld.actions.auth

import com.auth0.jwt.interfaces.DecodedJWT
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.realworld.actions.assertOnOkValue
import org.realworld.actions.auth.service.HasuraTokens
import org.realworld.actions.auth.service.User
import org.realworld.actions.utils.andThen

class TokenServiceTest {

    private val namespace = "https://hasura.io/jwt/claims"
    private val secret = "very-secret-secret"
    private val tokenService = HasuraTokens(secret)

    @Test
    fun `generates a JWT with username and email claims`() {
        val details = userDetails()
        val token = tokenService
            .generate(details)
            .andThen(tokenService::decode)

        assertOnOkValue(token) {
            assertEquals(details.username, claimValueFor("username", it))
            assertEquals(details.email, claimValueFor("email", it))
        }
    }

    @Test
    fun `generates a JWT with hasura claims`() {
        val details = userDetails()
        val token = tokenService
            .generate(details)
            .andThen(tokenService::decode)

        assertOnOkValue(token) {
            val hasuraClaim = claimValueFor(namespace, it)

            assertTrue(hasuraClaim.contains("\"x-hasura-user-id\": ${details.id}"))
            assertTrue(hasuraClaim.contains("\"x-hasura-default-role\": \"user\""))
            assertTrue(hasuraClaim.contains("\"x-hasura-allowed-roles\": [\"user\"]"))
        }
    }

    private fun claimValueFor(claimName: String, jwt: DecodedJWT) =
        jwt.getClaim(claimName).asString()

    private fun userDetails() = User(
        id = 1,
        username = "andrew",
        email = "a@b.com",
        passwordHash = "abc123£ashdajskd",
        bio = "about me",
        profileImage = "http://bread.png"
    )
}