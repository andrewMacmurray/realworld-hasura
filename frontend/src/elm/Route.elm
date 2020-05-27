module Route exposing (Route(..), el, fromUrl, link, routeToString)

import Element exposing (Element)
import Element.Text as Text
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser as Parser exposing (oneOf, s, top)


type Route
    = Home
    | SignUp
    | SignIn


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map Home top
        , Parser.map SignUp (s "sign-up")
        , Parser.map SignIn (s "sign-in")
        ]


link : Route -> String -> Element msg
link route label =
    el route (Text.link [] label)


el : Route -> Element msg -> Element msg
el route el_ =
    Element.link []
        { url = routeToString route
        , label = el_
        }


routeToString : Route -> String
routeToString route =
    case route of
        Home ->
            absolute [] []

        SignUp ->
            absolute [ "sign-up" ] []

        SignIn ->
            absolute [ "sign-in" ] []


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser
