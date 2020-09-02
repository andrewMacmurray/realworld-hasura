package org.realworld.actions.auth

object Requests {
    fun signup(
        username: String = "username",
        email: String = "a@b.com",
        password: String = "Abc12345!"
    ) = SignupRequest(
        username = username,
        email = email,
        password = password
    )

    fun login(username: String, password: String) =
        LoginRequest(
            username = username,
            password = password
        )
}