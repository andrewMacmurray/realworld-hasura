package org.realworld.actions.auth

import org.junit.jupiter.api.Test
import org.realworld.actions.assertIsOk
import org.realworld.actions.auth.service.HasuraTokens
import org.realworld.actions.auth.service.StoredPassword
import org.realworld.actions.pipe

class SignupTest {

    private val auth = Auth(
        password = StoredPassword,
        token = HasuraTokens("secret"),
        users = TODO()
    )

    private val signup = Signup(auth)

    @Test
    fun `signs up a user`() {
        SignupRequest(
            username = "username",
            email = "a@b.com",
            password = "abc12345!"
        )
            .pipe { signup.process(it) }
            .pipe { assertIsOk(it) }
    }
}
