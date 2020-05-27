module Article exposing
    ( Article
    , build
    , title
    )


type alias Article =
    { title : String
    , about : String
    }


build : String -> String -> Article
build =
    Article


title : Article -> String
title =
    .title
