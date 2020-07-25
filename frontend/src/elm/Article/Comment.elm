module Article.Comment exposing
    ( Comment
    , Comment_
    , build
    , by
    , date
    , equals
    , id
    , isBy
    , update
    , value
    )

import Article.Author exposing (Author)
import Date exposing (Date)
import User exposing (User)



-- Comment


type Comment
    = Comment Comment_


type alias Comment_ =
    { id : Int
    , value : String
    , date : Date
    , by : Author
    }



-- Construct


build : Comment_ -> Comment
build =
    Comment



-- Query


id : Comment -> Int
id =
    comment_ >> .id


by : Comment -> Author
by =
    comment_ >> .by


date : Comment -> Date
date =
    comment_ >> .date


value : Comment -> String
value =
    comment_ >> .value


isBy : User -> Comment -> Bool
isBy user comment =
    case user of
        User.Guest ->
            False

        User.Author profile ->
            User.equals profile (by comment)


equals : Comment -> Comment -> Bool
equals c1 c2 =
    id c1 == id c2


comment_ : Comment -> Comment_
comment_ (Comment c) =
    c



-- Update


update : Comment -> String -> Comment
update (Comment c) v =
    Comment { c | value = v }
