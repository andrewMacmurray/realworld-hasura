module Article exposing
    ( Article
    , ToCreate
    , about
    , author
    , build
    , createdAt
    , title
    , toCreate
    )

import Date exposing (Date)
import Tags exposing (Tag)


type alias ToCreate =
    { title : String
    , about : String
    , content : String
    , tags : List Tag
    }


type alias Article =
    { title : String
    , about : String
    , author : String
    , createdAt : Date
    }


toCreate : { i | title : String, about : String, content : String, tags : String } -> ToCreate
toCreate i =
    { title = i.title
    , about = i.about
    , content = i.content
    , tags = Tags.fromString i.tags
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
