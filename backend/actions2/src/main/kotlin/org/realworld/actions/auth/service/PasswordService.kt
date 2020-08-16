package org.realworld.actions.auth.service

import org.mindrot.jbcrypt.BCrypt
import org.realworld.actions.auth.service.PasswordError.FailsCriteria
import org.realworld.actions.auth.service.PasswordError.InvalidPassword
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.Result.Err
import org.realworld.actions.utils.Result.Ok
import org.realworld.actions.utils.toResult


// Password

interface PasswordService {
    fun hash(password: String): Result<PasswordError, String>
    fun verify(password: String, hash: String): Result<PasswordError, Unit>
}

// Hashed Password

object StoredPassword : PasswordService {
    override fun hash(password: String): Result<PasswordError, String> =
        if (password.meetsCriteria())
            hashWithSalt(password).toResult(FailsCriteria)
        else
            Err(FailsCriteria)

    override fun verify(password: String, hash: String): Result<PasswordError, Unit> =
        if (password.matches(hash)) Ok(Unit) else Err(InvalidPassword)

    private fun hashWithSalt(password: String): String? =
        BCrypt.hashpw(password, BCrypt.gensalt())

    private fun String.meetsCriteria(): Boolean =
        Criteria.passes(this)

    private fun String.matches(hash: String): Boolean =
        BCrypt.checkpw(this, hash)
}

private object Criteria {
    private const val lower = "(?=.*[a-z])"
    private const val upper = "(?=.*[A-Z])"
    private const val numbers = "(?=.*[0-9])"
    private const val above8 = "(?=.{8,})"

    fun passes(password: String): Boolean =
        password.contains("^$lower$upper$numbers$above8".toRegex())
}

// Errors

sealed class PasswordError {
    abstract val message: String

    object InvalidPassword : PasswordError() {
        override val message = "Invalid username / password combination"
    }

    object FailsCriteria : PasswordError() {
        override val message = """
            Password does not meet criteria (at least 8 characters with lowercase, uppercase, numbers)"
        """
    }
}