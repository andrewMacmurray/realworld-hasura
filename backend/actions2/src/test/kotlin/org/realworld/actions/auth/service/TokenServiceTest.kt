package org.realworld.actions.auth.service

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.User
import org.realworld.actions.utils.andThen
import org.realworld.actions.whenOk

class TokenServiceTest {

    private val tokens: TokenService =
        buildTokenService()

    @Test
    fun `generates a JWT with username and email claims`() {
        val details = userDetails()
        tokens
            .generate(details)
            .andThen(tokens::decode)
            .whenOk {
                assertEquals(details.username, it.username)
                assertEquals(details.email, it.email)
            }
    }

    @Test
    fun `generates a JWT with hasura claims`() {
        val details = userDetails()
        tokens
            .generate(details)
            .andThen(tokens::decode)
            .whenOk {
                assertTrue(it.permissions.contains(details.id.toString()))
            }
    }

    private fun buildTokenService(): TokenService =
        HasuraTokens("PTClNSJGXLA90wjPjzoz3hJCabHR8U16w")

    private fun userDetails() = User(
        id = 1,
        username = "andrew",
        email = "a@b.com",
        passwordHash = "abc123£ashdajskd",
        bio = "about me",
        profileImage = "http://bread.png"
    )
}