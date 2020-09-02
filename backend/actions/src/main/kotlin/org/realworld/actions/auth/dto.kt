package org.realworld.actions.auth

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
    val username: String,
    val email: String,
    val password: String
)

data class LoginRequest(
    val username: String,
    val password: String
)

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

