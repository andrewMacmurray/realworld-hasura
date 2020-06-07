module Article.Author.Feed exposing
    ( Feed
    , build
    , replaceArticle
    )

import Article exposing (Article)
import Article.Author exposing (Author)



-- Feed


type alias Feed =
    { author : Author
    , authoredArticles : List Article
    , likedArticles : List Article
    }



-- Construct


build : Maybe Author -> List Article -> List Article -> Maybe Feed
build author authored liked =
    case author of
        Just author_ ->
            Just (Feed author_ authored liked)

        Nothing ->
            Nothing



-- Update


replaceArticle : Article -> Feed -> Feed
replaceArticle article feed =
    { feed
        | authoredArticles = Article.replace article feed.authoredArticles
        , likedArticles = Article.replace article feed.likedArticles
    }
