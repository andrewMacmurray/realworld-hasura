module Helpers exposing (article)

import Article exposing (Article)
import Date
import Time exposing (Month(..))


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
