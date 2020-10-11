module Article.Page exposing
    ( Number
    , first
    , int
    , number
    , offset
    , size
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


offset : Number -> Int
offset page_ =
    (int page_ - 1) * size


size : number
size =
    10
