module Utils.String exposing
    ( NonEmpty
    , Optional
    , fromNonEmpty
    , fromOptional
    , pluralize
    , toNonEmpty
    , toOptional
    )

-- Utils


pluralize : String -> Int -> String
pluralize s n =
    if n == 1 then
        "1 " ++ s

    else
        String.fromInt n ++ " " ++ s ++ "s"



-- Non Empty


type NonEmpty
    = NonEmpty String


toNonEmpty : String -> Maybe NonEmpty
toNonEmpty str =
    if String.isEmpty str then
        Nothing

    else
        Just (NonEmpty str)


fromNonEmpty : NonEmpty -> String
fromNonEmpty (NonEmpty str) =
    str



-- Optional


type Optional
    = Entered String
    | Empty


toOptional : String -> Optional
toOptional str =
    if String.isEmpty str then
        Empty

    else
        Entered str


fromOptional : Optional -> Maybe String
fromOptional optional =
    case optional of
        Empty ->
            Nothing

        Entered str ->
            Just str
