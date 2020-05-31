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
    , profileImage
    , tags
    , title
    , toCreate
    )

import Date exposing (Date)
import Tag exposing (Tag)



-- Article


type Article
    = Article Article_


type alias Article_ =
    { id : Id
    , title : String
    , about : String
    , content : String
    , author : String
    , createdAt : Date
    , tags : List Tag
    }


type alias Id =
    Int


type alias ToCreate =
    { title : String
    , about : String
    , content : String
    , tags : List Tag
    }



-- Create


toCreate : { i | title : String, about : String, content : String, tags : String } -> ToCreate
toCreate i =
    { title = i.title
    , about = i.about
    , content = i.content
    , tags = Tag.parse i.tags
    }



-- Build


build : Id -> String -> String -> String -> String -> Date -> List Tag -> Article
build id_ title_ about_ content_ author_ createdAt_ tags_ =
    Article
        { id = id_
        , title = title_
        , about = about_
        , content = content_
        , author = author_
        , createdAt = createdAt_
        , tags = tags_
        }



-- Query


id : Article -> Id
id =
    article_ >> .id


title : Article -> String
title =
    article_ >> .title


about : Article -> String
about =
    article_ >> .about


content : Article -> String
content =
    article_ >> .content


author : Article -> String
author =
    article_ >> .author


createdAt : Article -> Date
createdAt =
    article_ >> .createdAt


tags : Article -> List Tag
tags =
    article_ >> .tags


profileImage : Article -> String
profileImage _ =
    "https://static.productionready.io/images/smiley-cyrus.jpg"


article_ : Article -> Article_
article_ (Article a) =
    a
