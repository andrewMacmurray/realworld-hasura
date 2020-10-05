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
        [ Parser.map OpenMenu (s effect </> s open)
        , Parser.map CloseMenu (s effect </> s close)
        ]


effect : String
effect =
    "route-effect"


open : String
open =
    "open-menu"


close : String
close =
    "close-menu"



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
            absolute [ effect, open ] []

        CloseMenu ->
            absolute [ effect, close ] []
