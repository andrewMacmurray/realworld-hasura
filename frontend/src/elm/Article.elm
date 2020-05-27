module Article exposing (Article, build, title)


type Article
    = Article Article_


type alias Article_ =
    { title : String
    , about : String
    }


build : String -> String -> Article
build title_ about_ =
    Article
        { title = title_
        , about = about_
        }


title : Article -> String
title =
    article_ >> .title


article_ (Article a) =
    a
