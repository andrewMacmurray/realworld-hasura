module Article.Author exposing
    ( Author
    , Id
    , build
    , id
    , profileImage
    , username
    )

-- Author


type Author
    = Author Author_


type alias Author_ =
    { id : Id
    , username : String
    , profileImage : Maybe String
    }


type alias Id =
    Int



-- Construct


build : Id -> String -> Maybe String -> Author
build id_ username_ profileImage_ =
    Author
        { id = id_
        , username = username_
        , profileImage = profileImage_
        }



-- Query


id : Author -> Id
id =
    author_ >> .id


username : Author -> String
username =
    author_ >> .username


profileImage : Author -> Maybe String
profileImage =
    author_ >> .profileImage



-- Helpers


author_ : Author -> Author_
author_ (Author a) =
    a
