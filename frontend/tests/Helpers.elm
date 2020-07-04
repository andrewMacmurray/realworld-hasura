module Helpers exposing
    ( article
    , articleBy
    , articleLikedBy
    , author
    , serverError
    )

import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Date
import Graphql.Http exposing (HttpError(..), RawError(..))
import Time exposing (Month(..))


serverError : Graphql.Http.Error a
serverError =
    HttpError NetworkError


articleLikedBy : String -> { a | title : String } -> Article
articleLikedBy username { title } =
    Article.build { article_ | title = title, likedBy = [ author 1 username ] }


articleBy : Int -> String -> Article
articleBy authorId username =
    Article.build { article_ | author = author authorId username }


article : String -> Article
article title =
    Article.build { article_ | title = title }


author : Int -> String -> Author
author id username =
    Author.build id username Nothing


article_ : Article.Details
article_ =
    { id = 1
    , title = "a title"
    , about = "about something"
    , content = "contents"
    , author = author 1 "username"
    , createdAt = Date.fromCalendarDate 2020 Jan 20
    , tags = []
    , likes = 0
    , likedBy = []
    , comments = []
    }
