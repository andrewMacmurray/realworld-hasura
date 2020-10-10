module Article.Page exposing
    ( Number
    , first
    , int
    , number
    )


type Number
    = Number Int


first : Number
first =
    Number 1


number : Maybe Int -> Number
number =
    Maybe.map Number >> Maybe.withDefault first


int : Number -> Int
int (Number n) =
    n
