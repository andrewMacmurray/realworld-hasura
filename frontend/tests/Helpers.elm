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
    Article.build 1
        title
        "about something"
        "contents"
        (author 1 "author")
        (Date.fromCalendarDate 2020 Jan 20)
        []
        0
        [ author 1 username ]


articleBy : Int -> String -> Article
articleBy authorId username =
    Article.build 1
        "a title"
        "about something"
        "contents"
        (author authorId username)
        (Date.fromCalendarDate 2020 Jan 20)
        []
        0
        []


article : String -> Article
article title =
    Article.build 1
        title
        "about something"
        "contents"
        (author 1 "author")
        (Date.fromCalendarDate 2020 Jan 20)
        []
        0
        []


author : Int -> String -> Author
author id username =
    Author.build id username Nothing
