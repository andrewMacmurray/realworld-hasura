package org.realworld.actions.auth

import org.koin.dsl.module
import org.realworld.actions.Environment
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

class AuthComponents(
    override val password: PasswordService,
    override val token: TokenService,
    override val users: UsersRepository
) : Auth

object AuthModule {
    fun build() = module {
        single { StoredPassword as PasswordService }
        single { HasuraUsers(get()) as UsersRepository }
        single { HasuraTokens((get() as Environment).JWT_SECRET) as TokenService }
        single { AuthComponents(get(), get(), get()) as Auth }
        single { AuthActions(get()) }
        single { AuthController(get()) }
    }
}
