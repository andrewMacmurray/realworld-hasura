package org.realworld.actions.auth.service

import org.junit.jupiter.api.Test
import org.realworld.actions.assertIsError
import org.realworld.actions.assertIsOk
import org.realworld.actions.utils.map
import org.realworld.actions.utils.pipe

private val password: PasswordService =
    StoredPassword

class PasswordServiceServiceTest {

    @Test
    fun `hashes and verifies a password`() {
        val validPassword = "abCDE12345678!"
        password
            .hash(validPassword)
            .map { password.verify(validPassword, it) }
            .pipe(::assertIsOk)
    }

    @Test
    fun `password must contain at least 8 characters`() {
        val shortPassword = "abc123"
        password
            .hash(shortPassword)
            .pipe(::assertIsError)
    }

    @Test
    fun `password should contain a mixture of numbers and letters`() {
        val onlyLetters = "acbDefghijK"
        val onlyNumbers = "12345678910"

        password
            .hash(onlyLetters)
            .pipe(::assertIsError)

        password
            .hash(onlyNumbers)
            .pipe(::assertIsError)
    }
}