module Article.Feed exposing
    ( ForAuthor
    , Home
    , forAuthor
    )

import Article exposing (Article)
import Article.Author exposing (Author)
import Tag



-- Home Feed


type alias Home =
    { articles : List Article
    , popularTags : List Tag.Popular
    }



-- Author Feed


type alias ForAuthor =
    { articles : List Article
    , author : Author
    }


forAuthor : Maybe Author -> List Article -> Maybe ForAuthor
forAuthor author articles =
    Maybe.map (ForAuthor articles) author
