module Article exposing
    ( Article
    , Author
    , Feed
    , Id
    , ToCreate
    , about
    , author
    , build
    , content
    , createdAt
    , id
    , likedByMe
    , likes
    , profileImage
    , replace
    , tags
    , title
    , toCreate
    )

import Date exposing (Date)
import Tag exposing (Tag)
import User



-- Article


type Article
    = Article Article_


type alias Article_ =
    { id : Id
    , title : String
    , about : String
    , content : String
    , author : Author
    , createdAt : Date
    , tags : List Tag
    , likes : Int
    , likedBy : List Author
    }


type alias Author =
    String


type alias Id =
    Int


type alias ToCreate =
    { title : String
    , about : String
    , content : String
    , tags : List Tag
    }



-- Feed


type alias Feed =
    { articles : List Article
    , popularTags : List Tag.Popular
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


build : Id -> String -> String -> String -> String -> Date -> List Tag -> Int -> List Author -> Article
build id_ title_ about_ content_ author_ createdAt_ tags_ likes_ likedBy_ =
    Article
        { id = id_
        , title = title_
        , about = about_
        , content = content_
        , author = author_
        , createdAt = createdAt_
        , tags = tags_
        , likes = likes_
        , likedBy = likedBy_
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


likes : Article -> Int
likes =
    article_ >> .likes


likedByMe : User.Profile -> Article -> Bool
likedByMe profile article =
    List.member (User.username profile) (likedBy article)


likedBy : Article -> List Author
likedBy =
    article_ >> .likedBy


profileImage : Article -> String
profileImage _ =
    "https://static.productionready.io/images/smiley-cyrus.jpg"


equals : Article -> Article -> Bool
equals a b =
    id a == id b



-- Update


replace : Article -> Feed -> Feed
replace article feed =
    { feed | articles = List.map (replace_ article) feed.articles }


replace_ : Article -> Article -> Article
replace_ articleA articleB =
    if equals articleA articleB then
        articleA

    else
        articleB



-- Helpers


article_ : Article -> Article_
article_ (Article a) =
    a
