module Helpers exposing (article, articleLikedBy)

import Article exposing (Article)
import Date
import Time exposing (Month(..))


articleLikedBy : String -> { a | title : String } -> Article
articleLikedBy username { title } =
    Article.build 1
        title
        "about something"
        "author"
        "contents"
        (Date.fromCalendarDate 2020 Jan 20)
        []
        0
        [ username ]


article : String -> Article
article title =
    Article.build 1
        title
        "about something"
        "author"
        "contents"
        (Date.fromCalendarDate 2020 Jan 20)
        []
        0
        []
