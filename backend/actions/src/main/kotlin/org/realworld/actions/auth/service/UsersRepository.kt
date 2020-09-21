package org.realworld.actions.auth.service

import com.expediagroup.graphql.types.GraphQLResponse
import kotlinx.coroutines.runBlocking
import org.realworld.actions.HasuraClient
import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.Mappers.toUser
import org.realworld.actions.auth.service.Mappers.variables
import org.realworld.actions.auth.service.UsersError.UserCreateError
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe
import org.realworld.actions.utils.toResult
import org.realworld.generated.CreateUserMutation
import org.realworld.generated.FindUserQuery

interface UsersRepository {
    fun create(user: User.ToCreate): Result<UsersError, User>
    fun find(username: String): User?
}

class HasuraUsers(private val client: HasuraClient) : UsersRepository {

    override fun create(user: User.ToCreate): Result<UsersError, User> = runBlocking {
        user.variables()
            .pipe { createMutation(it) }
            .pipe(::toUser)
    }

    private suspend fun createMutation(it: CreateUserMutation.Variables) = try {
        CreateUserMutation(client).execute(it)
    } catch (e: Exception) {
        throw Exception("creating went wrong $e")
    }

    override fun find(username: String): User? = runBlocking {
        FindUserQuery.Variables(username)
            .pipe { FindUserQuery(client).execute(it) }
            .pipe(::toUser)
    }

    private fun toUser(response: GraphQLResponse<CreateUserMutation.Result>): Result<UsersError, User> {
        return response.data
            ?.create_user
            ?.toUser()
            .toResult(UserCreateError)
    }

    private fun toUser(response: GraphQLResponse<FindUserQuery.Result>): User? =
        response.data
            ?.users
            ?.get(0)
            ?.toUser()
}

sealed class UsersError {
    abstract val message: String

    object UserCreateError : UsersError() {
        override val message: String = "Error creating user"
    }
}

private object Mappers {
    fun User.ToCreate.variables() =
        CreateUserMutation.Variables(
            username = username,
            email = email,
            password_hash = passwordHash
        )

    fun FindUserQuery.users.toUser() = User(
        id = id,
        username = username,
        email = email,
        passwordHash = password_hash,
        profileImage = profile_image,
        bio = bio
    )

    fun CreateUserMutation.users.toUser() = User(
        id = id,
        username = username,
        email = email,
        passwordHash = password_hash,
        bio = bio,
        profileImage = profile_image
    )
}