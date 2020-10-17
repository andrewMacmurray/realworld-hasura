module Article.Page exposing
    ( Number
    , first
    , number
    , offset
    , size
    , view
    )

import Element exposing (..)
import Element.Button as Button
import Element.Scale as Scale



-- Page Number


type Number
    = Number Int



-- Config


size : number
size =
    8



-- Construct


first : Number
first =
    Number 1



-- Query


number : Number -> Int
number (Number n) =
    n


offset : Number -> Int
offset page_ =
    (number page_ - 1) * size


lastPage : Int -> Int
lastPage total =
    (total // size) + 1



-- View


type alias Options msg =
    { total : Int
    , loading : Bool
    , onClick : msg
    }


view : Options msg -> Element msg
view options =
    if options.total <= size then
        none

    else
        el [ spacing Scale.extraSmall ] (loadMore options)


loadMore options =
    let
        text =
            "Load more"
    in
    if options.loading then
        Button.decorative text
            |> Button.loadMore
            |> Button.loading
            |> Button.toElement

    else
        Button.button options.onClick text
            |> Button.loadMore
            |> Button.toElement
