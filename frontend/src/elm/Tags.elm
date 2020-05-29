module Tags exposing
    ( Tag
    , fromString
    , value
    )

import Regex



-- Tag


type Tag
    = Tag String



-- Construct


fromString : String -> List Tag
fromString =
    Regex.replace specialCharacters (always " ")
        >> String.words
        >> List.filter (not << String.isEmpty)
        >> List.map Tag



-- Query


value : Tag -> String
value (Tag t) =
    t



-- Helpers


specialCharacters : Regex.Regex
specialCharacters =
    Maybe.withDefault Regex.never (Regex.fromString specialCharacters_)


specialCharacters_ : String
specialCharacters_ =
    """\\`|\\~|\\!|\\@|\\#|\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\+|\\=|\\[|\\{|\\]|\\}|\\||\\|'|\\<|\\,|\\.|\\>|\\?|\\/|\\|\\;|\\:|\\s"""
