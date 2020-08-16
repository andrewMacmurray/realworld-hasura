package org.realworld.actions.auth

import org.realworld.actions.auth.service.Token

data class User(
    val id: Int,
    val email: String,
    val username: String,
    val passwordHash: String,
    val bio: String?,
    val profileImage: String?
) {
    data class ToCreate(
        val username: String,
        val email: String,
        val passwordHash: String
    )

    data class Login(
        val token: Token,
        val user: User
    )
}

