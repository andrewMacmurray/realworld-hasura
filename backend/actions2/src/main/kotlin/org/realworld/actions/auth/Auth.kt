package org.realworld.actions.auth

import org.realworld.actions.Environment
import org.realworld.actions.HasuraClient
import org.realworld.actions.auth.actions.Login
import org.realworld.actions.auth.actions.Signup
import org.realworld.actions.auth.service.*

interface Auth {
    val password: PasswordService
    val token: TokenService
    val users: UsersRepository
}

class AuthActions(auth: Auth) {
    val login = Login(auth)
    val signup = Signup(auth)
}

class AuthComponents(client: HasuraClient, env: Environment) : Auth {
    override val password: PasswordService = StoredPassword
    override val token: TokenService = HasuraTokens(env.JWT_SECRET)
    override val users: UsersRepository = HasuraUsers(client)
}


