module Article.Page exposing
    ( Number
    , first
    , next
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


offset : Number -> Int
offset page_ =
    (number_ page_ - 1) * size


isLastPage : { options | total : Int, page : Number } -> Bool
isLastPage { total, page } =
    number_ page == lastPage total


lastPage : Int -> Int
lastPage total =
    (total // size) + 1


number_ : Number -> Int
number_ (Number n) =
    n



-- Update


next : Number -> Number
next (Number n) =
    Number (n + 1)



-- View


type alias Options msg =
    { total : Int
    , page : Number
    , loading : Bool
    , onClick : msg
    }


view : Options msg -> Element msg
view options =
    if options.total <= size || isLastPage options then
        none

    else
        el [ spacing Scale.extraSmall, centerX ] (loadMore options)


loadMore : Options msg -> Element msg
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
