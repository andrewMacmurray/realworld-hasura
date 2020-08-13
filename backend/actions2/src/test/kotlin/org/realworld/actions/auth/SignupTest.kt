package org.realworld.actions.auth

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.realworld.actions.assertWhenOk
import org.realworld.actions.auth.service.HasuraTokens
import org.realworld.actions.auth.service.StoredPassword
import org.realworld.actions.auth.service.Token
import org.realworld.actions.auth.service.TokenError
import org.realworld.actions.pipe
import org.realworld.actions.utils.andThen
import org.realworld.actions.utils.mapError

class SignupTest {

    private val repository = MockUsersRepository()
    private val tokens = HasuraTokens("secret")
    private val auth = Auth(
        password = StoredPassword,
        token = tokens,
        users = repository
    )

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
        tokens.decode(token).mapError(TokenError::message)

    private fun signupRequest(
        username: String = "username",
        email: String = "a@b.com",
        password: String = "Abc12345!"
    ) = SignupRequest(
        username = username,
        email = email,
        password = password
    )
}
