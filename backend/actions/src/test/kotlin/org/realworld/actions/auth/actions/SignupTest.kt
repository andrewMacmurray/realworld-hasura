package org.realworld.actions.auth.actions

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.Requests
import org.realworld.actions.auth.UsersError
import org.realworld.actions.auth.doubles.AuthDoubles
import org.realworld.actions.utils.pipe
import org.realworld.actions.whenError
import org.realworld.actions.whenOk

class SignupTest {

    private val auth = AuthDoubles()
    private val repository = auth.users
    private val actions = auth.actions

    @BeforeEach
    fun setup() {
        repository.reset()
    }

    @Test
    fun `adds a signed up user to the repository`() {
        Requests.signup().pipe { actions.signup.process(it) }

        assertEquals(1, repository.users.size)
    }

    @Test
    fun `generates a token for the user`() {
        val request = Requests.signup()

        actions.signup
            .process(request)
            .whenOk { assertEquals(userId(request.username), it.userId) }
    }

    @Test
    fun `rejects usernames that are too long`() {
        Requests.signup(username = "a-long-long-long-username")
            .pipe { actions.signup.process(it) }
            .whenError {
                assertEquals(UsersError.UsernameTooLong.message, it)
            }
    }

    private fun userId(username: String): Int =
        repository.find(username)!!.id
}