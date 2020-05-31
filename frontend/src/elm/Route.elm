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
import Tag exposing (Tag)
import Url exposing (Url)
import Url.Builder as Url exposing (absolute)
import Url.Parser as Parser exposing ((</>), (<?>), int, oneOf, s, top)
import Url.Parser.Query as Query



-- Route


type Route
    = Home (Maybe Tag)
    | SignUp
    | SignIn
    | NewPost
    | Settings
    | Article Article.Id


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map Home (top <?> tagQuery)
        , Parser.map SignUp (s "sign-up")
        , Parser.map SignIn (s "sign-in")
        , Parser.map NewPost (s "new-post")
        , Parser.map Settings (s "settings")
        , Parser.map Article (s "article" </> int)
        ]


tagQuery : Query.Parser (Maybe Tag)
tagQuery =
    Query.string "tag" |> Query.map (Maybe.map Tag.one)


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
        Home tag_ ->
            absolute [] (toTagQuery_ tag_)

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


toTagQuery_ : Maybe Tag -> List Url.QueryParameter
toTagQuery_ =
    Maybe.map (Tag.value >> Url.string "tag" >> List.singleton) >> Maybe.withDefault []


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser
