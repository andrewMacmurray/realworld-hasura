package org.realworld.actions.auth.service

import com.expediagroup.graphql.types.GraphQLResponse
import kotlinx.coroutines.runBlocking
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.UsersError.UserCreateError
import org.realworld.actions.hasura.HasuraClient
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe
import org.realworld.actions.utils.toResult
import org.realworld.generated.CreateUser

interface UsersRepository {
    fun create(user: User.ToCreate): Result<UsersError, User>
}

class HasuraUsers(private val client: HasuraClient) : UsersRepository {
    override fun create(user: User.ToCreate): Result<UsersError, User> = runBlocking {
        user.variables()
            .pipe { CreateUser(client).execute(it) }
            .pipe(::toUser)
    }

    private fun toUser(response: GraphQLResponse<CreateUser.Result>): Result<UsersError, User> =
        response.data
            ?.create_user
            ?.toUser()
            .toResult(UserCreateError)
}


private fun User.ToCreate.variables() = CreateUser.Variables(
    username = this.username,
    email = this.email,
    password_hash = this.passwordHash
)

private fun CreateUser.users.toUser() = User(
    id = this.id,
    username = this.username,
    email = this.email,
    passwordHash = this.password_hash,
    bio = this.bio,
    profileImage = this.profile_image
)

sealed class UsersError {
    abstract val message: String

    object UserCreateError : UsersError() {
        override val message: String = "Error creating user"
    }
}
