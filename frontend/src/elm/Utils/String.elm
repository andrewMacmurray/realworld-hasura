module Utils.String exposing
    ( capitalize
    , pluralize
    )


capitalize : String -> String
capitalize s =
    String.concat
        [ String.toUpper (String.left 1 s)
        , String.toLower (String.dropLeft 1 s)
        ]


pluralize : String -> Int -> String
pluralize s n =
    if n == 1 then
        "1 " ++ s

    else
        String.fromInt n ++ " " ++ s ++ "s"
