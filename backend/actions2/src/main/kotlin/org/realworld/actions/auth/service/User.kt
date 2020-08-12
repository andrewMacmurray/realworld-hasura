package org.realworld.actions.auth.service

data class User(
    val id: Int,
    val email: String,
    val username: String,
    val passwordHash: String,
    val bio: String,
    val profileUrl: String
) {
    data class ToCreate(
        val username: String,
        val email: String,
        val passwordHash: String
    )
}

interface UsersRepository {
    fun create(user: User.ToCreate): User
}