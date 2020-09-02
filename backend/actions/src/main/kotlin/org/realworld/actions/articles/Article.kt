package org.realworld.actions.articles

import org.realworld.actions.auth.User

object Article {
    data class Id(val value: Int)
    data class Unlike(val id: Id, val userId: User.Id)
}