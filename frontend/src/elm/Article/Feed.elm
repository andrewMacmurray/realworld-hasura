module Article.Feed exposing
    ( Feed
    , ForAuthor
    , Home
    , forAuthor
    )

import Article exposing (Article)
import Article.Author exposing (Author)
import Tag



-- Feed


type alias Feed =
    { articles : List Article
    , count : Int
    }



-- Home Feed


type alias Home =
    { feed : Feed
    , popularTags : List Tag.Popular
    }



-- Author Feed


type alias ForAuthor =
    { feed : Feed
    , author : Author
    }


forAuthor : Maybe Author -> Feed -> Maybe ForAuthor
forAuthor author feed =
    Maybe.map (ForAuthor feed) author
