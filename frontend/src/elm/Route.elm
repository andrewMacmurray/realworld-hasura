module Route exposing (Route(..), fromUrl, link, routeToString)

import Element exposing (Element)
import Element.Text as Text
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser as Parser exposing (oneOf, s, top)


type Route
    = Home
    | Signup


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map Home top
        , Parser.map Signup (s "signup")
        ]


link : Route -> String -> Element msg
link route label =
    Element.link []
        { url = routeToString route
        , label = Text.link [] label
        }


routeToString : Route -> String
routeToString route =
    case route of
        Home ->
            absolute [] []

        Signup ->
            absolute [ "signup" ] []


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser
