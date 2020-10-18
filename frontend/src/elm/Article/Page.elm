module Article.Page exposing
    ( Number
    , first
    , loadMoreButton
    , next
    , offset
    , size
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


isLastPage : { options | totalArticles : Int, page : Number } -> Bool
isLastPage { totalArticles, page } =
    number_ page == lastPage totalArticles


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
    { totalArticles : Int
    , page : Number
    , loading : Bool
    , onClick : msg
    }


loadMoreButton : Options msg -> Element msg
loadMoreButton options =
    if options.totalArticles <= size || isLastPage options then
        none

    else
        el [ spacing Scale.extraSmall ] (loadMore options)


loadMore : Options msg -> Element msg
loadMore options =
    let
        text =
            "Load more"
    in
    if options.loading then
        Button.decorative text
            |> Button.loadMore
            |> Button.conduit
            |> Button.toElement

    else
        Button.button options.onClick text
            |> Button.loadMore
            |> Button.toElement
