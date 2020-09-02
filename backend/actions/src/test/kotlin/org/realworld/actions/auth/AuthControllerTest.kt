package org.realworld.actions.auth

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.doubles.AuthDoubles
import org.realworld.actions.parseBody
import org.realworld.actions.post
import org.realworld.actions.utils.pipe

class AuthControllerTest {

    private val auth = AuthDoubles()
    private val token = auth.tokens.token
    private val controller = auth.controller

    @Test
    fun `handles signup`() {
        val request = Requests.signup()

        signupUser(request).pipe {
            assertEquals(request.username, it.username)
            assertEquals(token, it.token)
        }
    }

    @Test
    fun `handles login`() {
        val username = "anne.onymous"
        val password = "Abc12345!"
        val request = Requests.login(username, password)

        Requests.signup(username, password)
            .pipe { signupUser(it) }
            .pipe { loginUser(request) }
            .pipe {
                assertEquals(request.username, it.username)
                assertEquals(token, it.token)
            }
    }

    private fun loginUser(request: LoginRequest): LoginResponse =
        controller.post("/login", request).parseBody()

    private fun signupUser(request: SignupRequest): SignupResponse =
        controller.post("/signup", request).parseBody()
}
