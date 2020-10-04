package org.realworld.actions.auth

import org.realworld.actions.auth.UsersError.UsernameTooLong
import org.realworld.actions.auth.service.Token
import org.realworld.actions.utils.Result

data class User(
    val id: Int,
    val email: String,
    val username: String,
    val passwordHash: String,
    val bio: String?,
    val profileImage: String?
) {
    data class Id(val value: Int)

    data class ToCreate(
        val username: String,
        val email: String,
        val passwordHash: String
    ) {
        fun validate(): Result<UsersError, ToCreate> = if (username.length > 16) {
            Result.Err(UsernameTooLong)
        } else {
            Result.Ok(this)
        }
    }

    data class Login(
        val token: Token,
        val user: User
    )
}

sealed class UsersError {
    abstract val message: String

    object DuplicateUser : UsersError() {
        override val message: String = "That username is already taken"
    }

    object UsernameTooLong : UsersError() {
        override val message: String = "That username is too long (maximum 16 characters)"
    }
}

