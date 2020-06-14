module Article.Author.Feed exposing
    ( Feed
    , build
    )

import Article exposing (Article)
import Article.Author exposing (Author)



-- Feed


type alias Feed =
    { articles : List Article
    , author : Author
    }



-- Build


build : Maybe Author -> List Article -> Maybe Feed
build author articles_ =
    Maybe.map (Feed articles_) author
