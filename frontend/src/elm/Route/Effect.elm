module Route.Effect exposing
    ( Route(..)
    , el
    , fromUrl
    )

import Element exposing (Element)
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser as Parser exposing ((</>), oneOf, s)



{--
    Effect Route
    Use to trigger a global update onClick from an Element with no Msg
--}


type Route
    = OpenMenu
    | CloseMenu



-- Parse


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map OpenMenu (s effect </> s "open-menu")
        , Parser.map CloseMenu (s effect </> s "close-menu")
        ]


effect : String
effect =
    "route-effect"



-- Render


el : Route -> Element msg -> Element msg
el route el_ =
    Element.link []
        { url = routeToString route
        , label = el_
        }


routeToString : Route -> String
routeToString route =
    case route of
        OpenMenu ->
            absolute [ effect, "open-menu" ] []

        CloseMenu ->
            absolute [ effect, "close-menu" ] []
