module Article exposing
    ( Article
    , about
    , author
    , build
    , createdAt
    , title
    )

import Date exposing (Date)


type alias Article =
    { title : String
    , about : String
    , author : String
    , createdAt : Date
    }


build =
    Article


title : Article -> String
title =
    .title


about : Article -> String
about =
    .about


author : Article -> String
author =
    .author


createdAt : Article -> Date
createdAt =
    .createdAt
