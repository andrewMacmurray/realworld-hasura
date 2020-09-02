package org.realworld.actions.auth.actions

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.Requests
import org.realworld.actions.auth.SignupRequest
import org.realworld.actions.auth.User
import org.realworld.actions.auth.doubles.AuthDoubles
import org.realworld.actions.auth.service.PasswordError.InvalidLogin
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe
import org.realworld.actions.whenError
import org.realworld.actions.whenOk

class LoginTest {

    private val auth = AuthDoubles()
    private val actions = auth.actions
    private val repository = auth.users

    @BeforeEach
    fun setup() {
        repository.reset()
    }

    @Test
    fun `logs in an existing user`() {
        val signup = signupUser()

        login(signup.username, signup.password).whenOk {
            assertEquals(signup.username, it.user.username)
            assertEquals(signup.email, it.user.email)
        }
    }

    @Test
    fun `rejects a non existing user`() {
        login("anne.onymous", "ImNoTReallyHere!7").whenError {
            assertEquals(InvalidLogin.message, it)
        }
    }

    @Test
    fun `rejects an incorrect password`() {
        val incorrectPassword = "Bcd45678!!"
        val signup = signupUser("anne.onymous", "Abc12345!")

        login(signup.username, incorrectPassword).whenError {
            assertEquals(InvalidLogin.message, it)
        }
    }

    private fun login(username: String, password: String): Result<String, User.Login> =
        Requests.login(username, password).pipe { actions.login.process(it) }

    private fun signupUser(
        username: String = "anne.onymous",
        password: String = "Abc12345!"
    ): SignupRequest {
        val user = Requests.signup(username, password)
        actions.signup.process(user)
        return user
    }
}
