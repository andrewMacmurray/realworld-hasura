package org.realworld.actions.articles

import org.http4k.core.Method
import org.http4k.routing.RoutingHttpHandler
import org.http4k.routing.bind
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.User
import org.realworld.actions.utils.map
import org.realworld.actions.utils.pipe
import org.realworld.actions.web.Action
import org.realworld.actions.web.Controller

class ArticlesController(private val actions: Articles.Actions) : Controller {

    override val handler: RoutingHttpHandler =
        "/unlike" bind Method.POST to Action.handleForUser(::unlikeArticle)

    private fun unlikeArticle(request: UnlikeRequest, userId: User.Id): ActionResult<UnlikeResponse> =
        request.toUnlike(userId)
            .pipe(actions.unlike::process)
            .map(Article.Id::toUnlikeResponse)
}

