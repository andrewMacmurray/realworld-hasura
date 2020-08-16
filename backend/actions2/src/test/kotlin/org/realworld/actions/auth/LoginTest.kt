package org.realworld.actions.auth

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.realworld.actions.whenOk
import org.realworld.actions.auth.doubles.MockAuth
import org.realworld.actions.auth.doubles.MockUsersRepository
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.mapError
import org.realworld.actions.utils.pipe

class LoginTest {

    private val auth = MockAuth()
    private val actions = AuthActions(auth)

    @BeforeEach
    fun setup() {
        repository.reset()
    }

    @Test
    fun `adds a signed up user to the repository`() {
        Requests.signup().pipe { actions.signup.process(it) }

        Assertions.assertEquals(1, repository.users.size)
    }

    @Test
    fun `generates a token for the user`() {
        Requests.signup(username = "andrew")
            .pipe { actions.signup.process(it) }
            .andThen { decodeToken(it) }
            .whenOk { it.payload.contains("andrew") }
    }

    private fun decodeToken(token: Token) =
        auth.token.decode(token).mapError(TokenError::message)

    private val repository: MockUsersRepository
        get() = auth.users
}