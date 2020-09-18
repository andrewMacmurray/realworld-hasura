package org.realworld.actions.auth.web

import org.realworld.actions.auth.User
import org.realworld.actions.auth.actions.Login
import org.realworld.actions.auth.actions.Signup
import org.realworld.actions.auth.service.Token

data class SignupResponse(
    val token: String,
    val user_id: Int,
    val username: String,
    val email: String,
    val bio: String?,
    val profile_image: String?
)

data class SignupRequest(
    override val username: String,
    override val email: String,
    override val password: String
) : Signup.Input

data class LoginRequest(
    override val username: String,
    override val password: String
) : Login.Input

data class LoginResponse(
    val token: String,
    val user_id: Int,
    val username: String,
    val email: String,
    val bio: String?,
    val profile_image: String?
)

fun User.Login.toLoginResponse() = LoginResponse(
    token = token.value,
    user_id = user.id,
    username = user.username,
    email = user.email,
    bio = user.bio,
    profile_image = user.profileImage
)

fun SignupRequest.toSignupResponse(token: Token) = SignupResponse(
    token = token.value,
    user_id = token.userId,
    username = username,
    email = email,
    bio = null,
    profile_image = null
)

