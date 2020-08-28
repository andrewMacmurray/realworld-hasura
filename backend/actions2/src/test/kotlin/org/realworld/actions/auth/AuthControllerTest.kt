package org.realworld.actions.auth

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.doubles.MockAuth
import org.realworld.actions.auth.doubles.TokensStub
import org.realworld.actions.bodyAs
import org.realworld.actions.post
import org.realworld.actions.utils.pipe

class AuthControllerTest {

    private val token = "TOKEN"
    private val controller = buildController(token)

    @Test
    fun `handles signup`() {
        Requests.signup()
            .pipe { controller.post("/signup", it) }
            .pipe { it.bodyAs<SignupResponse>() }
            .pipe { assertEquals(token, it.token) }
    }

    private fun buildController(token: String) =
        TokensStub(token)
            .pipe(::MockAuth)
            .pipe(::AuthActions)
            .pipe(::AuthController)
}

