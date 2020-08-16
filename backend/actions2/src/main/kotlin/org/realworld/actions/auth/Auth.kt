package org.realworld.actions.auth

import org.realworld.actions.Environment
import org.realworld.actions.auth.actions.Login
import org.realworld.actions.auth.actions.Signup
import org.realworld.actions.auth.service.*
import org.realworld.actions.hasura.ClientBuilder

interface Auth {
    val password: PasswordService
    val token: TokenService
    val users: UsersRepository
}

class AuthActions(auth: Auth) {
    val login = Login(auth)
    val signup = Signup(auth)
}

class AuthComponents : Auth {
    private val client = ClientBuilder(Environment).build()
    override val password: PasswordService = StoredPassword
    override val token: TokenService = HasuraTokens(Environment.JWT_SECRET)
    override val users: UsersRepository = HasuraUsers(client)
}


