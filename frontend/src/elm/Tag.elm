module Tag exposing
    ( Tag
    , one
    , parse
    , value
    )

import Regex



-- Tag


type Tag
    = Tag String



-- Construct


one : String -> Tag
one =
    Tag


parse : String -> List Tag
parse =
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
