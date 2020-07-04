module Article exposing
    ( Article
    , Comment
    , Details
    , Feed
    , Id
    , ToCreate
    , about
    , author
    , authorUsername
    , build
    , comments
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

import Article.Author as Author exposing (Author)
import Date exposing (Date)
import Tag exposing (Tag)
import User exposing (User)



-- Article


type Article
    = Article Details


type alias Details =
    { id : Id
    , title : String
    , about : String
    , content : String
    , author : Author
    , createdAt : Date
    , tags : List Tag
    , likes : Int
    , likedBy : List Author
    , comments : List Comment
    }


type alias Id =
    Int


type alias ToCreate =
    { title : String
    , about : String
    , content : String
    , tags : List Tag
    }


type alias Comment =
    { id : Int
    , comment : String
    , date : Date
    , by : Author
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


build : Details -> Article
build =
    Article



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


author : Article -> Author
author =
    article_ >> .author


authorUsername : Article -> String
authorUsername =
    author >> Author.username


createdAt : Article -> Date
createdAt =
    article_ >> .createdAt


tags : Article -> List Tag
tags =
    article_ >> .tags


likes : Article -> Int
likes =
    article_ >> .likes


comments : Article -> List Comment
comments =
    article_ >> .comments


likedByMe : User.Profile -> Article -> Bool
likedByMe profile article =
    likedBy article
        |> List.map Author.username
        |> List.member (User.username profile)


likedBy : Article -> List Author
likedBy =
    article_ >> .likedBy


profileImage : Article -> Maybe String
profileImage =
    author >> Author.profileImage


equals : Article -> Article -> Bool
equals a b =
    id a == id b



-- Update


replace : Article -> List Article -> List Article
replace article =
    List.map (replace_ article)


replace_ : Article -> Article -> Article
replace_ articleA articleB =
    if equals articleA articleB then
        articleA

    else
        articleB



-- Helpers


article_ : Article -> Details
article_ (Article a) =
    a
