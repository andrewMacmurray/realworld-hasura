module Article exposing
    ( Article
    , Id
    , ToCreate
    , about
    , author
    , build
    , content
    , createdAt
    , id
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


type alias Id =
    Int


type alias Article =
    { id : Id
    , title : String
    , about : String
    , content : String
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


id : Article -> Id
id =
    .id


title : Article -> String
title =
    .title


about : Article -> String
about =
    .about


content : Article -> String
content =
    .content


author : Article -> String
author =
    .author


createdAt : Article -> Date
createdAt =
    .createdAt
