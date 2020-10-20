module Tag exposing
    ( Popular
    , Tag
    , one
    , parse
    , value
    )

import Regex



-- Tag


type Tag
    = Tag String


type alias Popular =
    { tag : Tag
    , count : Int
    }



-- Single


one : String -> Tag
one =
    Tag



-- Parse


parse : String -> List Tag
parse =
    Regex.replace specialCharacters (always " ")
        >> String.words
        >> removeEmpties
        >> format
        >> removeDuplicates
        >> List.map Tag


removeEmpties : List String -> List String
removeEmpties =
    List.filter (not << String.isEmpty)


format : List String -> List String
format =
    List.map String.toLower


removeDuplicates : List a -> List a
removeDuplicates =
    List.foldr addTag []


addTag : a -> List a -> List a
addTag tag tags =
    if List.member tag tags then
        tags

    else
        tag :: tags



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
    "\\`|\\~|\\!|\\@|\\#|\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\+|\\=|\\[|\\{|\\]|\\}|\\||\\|'|\\<|\\,|\\.|\\>|\\?|\\/|\\|\\;|\\:|\\s"
