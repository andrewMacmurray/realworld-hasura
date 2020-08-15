package org.realworld.actions.auth

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.realworld.actions.assertWhenOk
import org.realworld.actions.auth.doubles.MockAuth
import org.realworld.actions.auth.doubles.MockUsersRepository
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.mapError
import org.realworld.actions.utils.pipe

class SignupTest {

    private val auth = MockAuth()
    private val signup = Signup(auth)

    @BeforeEach
    fun setup() {
        repository.reset()
    }

    @Test
    fun `adds a signed up user to the repository`() {
        signupRequest().pipe { signup.process(it) }

        assertEquals(1, repository.users.size)
    }

    @Test
    fun `generates a token for the user`() {
        signupRequest(username = "andrew")
            .pipe { signup.process(it) }
            .andThen { decodeToken(it) }
            .assertWhenOk { it.payload.contains("andrew") }
    }

    private fun decodeToken(token: Token) =
        auth.token.decode(token).mapError(TokenError::message)

    private fun signupRequest(
        username: String = "username",
        email: String = "a@b.com",
        password: String = "Abc12345!"
    ) = SignupRequest(
        username = username,
        email = email,
        password = password
    )

    private val repository: MockUsersRepository
        get() = auth.users
}
