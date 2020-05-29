module Route exposing
    ( Route(..)
    , el
    , fromUrl
    , link
    , routeToString
    )

import Article
import Element exposing (Element)
import Element.Anchor as Anchor
import Element.Text as Text
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser as Parser exposing ((</>), int, oneOf, s, top)



-- Route


type Route
    = Home
    | SignUp
    | SignIn
    | NewPost
    | Settings
    | Article Article.Id


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map Home top
        , Parser.map SignUp (s "sign-up")
        , Parser.map SignIn (s "sign-in")
        , Parser.map NewPost (s "new-post")
        , Parser.map Settings (s "settings")
        , Parser.map Article (s "article" </> int)
        ]


link : Route -> String -> Element msg
link route label =
    let
        description =
            Anchor.description (label ++ "-link")
    in
    el route (Text.link [ description ] label)


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

        NewPost ->
            absolute [ "new-post" ] []

        Settings ->
            absolute [ "settings" ] []

        Article id ->
            absolute [ "article", String.fromInt id ] []


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser
