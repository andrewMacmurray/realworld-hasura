module Utils.String exposing (capitalize)


capitalize : String -> String
capitalize s =
    String.concat
        [ String.toUpper (String.left 1 s)
        , String.toLower (String.dropLeft 1 s)
        ]
