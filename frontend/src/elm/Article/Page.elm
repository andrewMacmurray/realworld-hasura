module Article.Page exposing
    ( Number
    , first
    , number
    , offset
    , size
    , toNumber
    , view
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text



-- Page Number


type Number
    = Number Int


type alias Page =
    { number : Int
    , current : Bool
    }



-- Config


size : number
size =
    8



-- Construct


first : Number
first =
    Number 1


toNumber : Maybe Int -> Number
toNumber =
    Maybe.map Number >> Maybe.withDefault first



-- Query


number : Number -> Int
number (Number n) =
    n


offset : Number -> Int
offset page_ =
    (number page_ - 1) * size


toPages : Number -> Int -> List Page
toPages page_ total =
    if total < size then
        []

    else
        lastPage total
            |> List.range 1
            |> List.map (toPage page_)


lastPage : Int -> Int
lastPage total =
    (total // size) + 1


toPage : Number -> Int -> Page
toPage page_ n =
    if n == number page_ then
        { current = True, number = n }

    else
        { current = False, number = n }



-- View


type alias Options =
    { page : Number
    , total : Int
    }


view : Options -> Element msg
view options =
    row [ spacing Scale.extraSmall ] (viewPages options.page options.total)


viewPages : Number -> Int -> List (Element msg)
viewPages page_ =
    toPages page_ >> List.map viewPage


viewPage : Page -> Element msg
viewPage page =
    if page.current then
        activePage page.number

    else
        inactivePage page.number


inactivePage : Int -> Element msg
inactivePage n =
    el
        [ width (px 25)
        , height (px 25)
        ]
        (centered (Text.text [ Text.black ] (String.fromInt n)))


activePage : Int -> Element msg
activePage n =
    el
        [ Border.rounded 100
        , Background.color Palette.green
        , width (px 25)
        , height (px 25)
        ]
        (centered (Text.text [ Text.white ] (String.fromInt n)))


centered : Element msg -> Element msg
centered =
    el
        [ centerY
        , centerX
        ]
