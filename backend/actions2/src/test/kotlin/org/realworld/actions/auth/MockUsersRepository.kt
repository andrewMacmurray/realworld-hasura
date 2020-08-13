package org.realworld.actions.auth

import org.realworld.actions.auth.service.User
import org.realworld.actions.auth.service.UsersRepository

class MockUsersRepository : UsersRepository {
    private var nextId: Int = 0
    var users: List<User> = emptyList()

    override fun create(user: User.ToCreate): User {
        val newUser = newUser(user, nextId)
        incrementId()
        storeUser(newUser)
        return newUser
    }

    private fun storeUser(newUser: User) {
        users = users + newUser
    }

    private fun incrementId() {
        nextId += 1
    }

    fun reset() {
        nextId = 0
        users = emptyList()
    }

    private fun newUser(user: User.ToCreate, id: Int) = User(
        id = id,
        username = user.username,
        email = user.email,
        passwordHash = user.passwordHash,
        profileImage = null,
        bio = null
    )
}