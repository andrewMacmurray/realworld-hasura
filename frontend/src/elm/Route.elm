module Route exposing
    ( Route(..)
    , author
    , el
    , fromUrl
    , home
    , link
    , routeToString
    , tagFeed
    )

import Article
import Article.Author as Author exposing (Author)
import Element exposing (Element)
import Element.Text as Text
import Tag exposing (Tag)
import Url exposing (Url)
import Url.Builder as Url exposing (absolute)
import Url.Parser as Parser exposing ((</>), (<?>), int, oneOf, s, top)
import Url.Parser.Query as Query
import User



-- Route


type Route
    = Home (Maybe Tag)
    | SignUp
    | SignIn
    | NewPost
    | Settings
    | Article Article.Id
    | Author User.Id


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map Home (top <?> tagQuery)
        , Parser.map SignUp (s "sign-up")
        , Parser.map SignIn (s "sign-in")
        , Parser.map NewPost (s "new-post")
        , Parser.map Settings (s "settings")
        , Parser.map Article (s "article" </> int)
        , Parser.map Author (s "author" </> int)
        ]


tagFeed : Tag -> Route
tagFeed tag =
    Home (Just tag)


home : Route
home =
    Home Nothing


author : Author -> Route
author =
    Author.id >> Author


tagQuery : Query.Parser (Maybe Tag)
tagQuery =
    Query.string "tag" |> Query.map (Maybe.map Tag.one)


link : Route -> String -> Element msg
link route label =
    el route (Text.link [ Text.description (label ++ "-link") ] label)


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

        Author id ->
            absolute [ "author", String.fromInt id ] []


toTagQuery_ : Maybe Tag -> List Url.QueryParameter
toTagQuery_ =
    Maybe.map (Tag.value >> Url.string "tag" >> List.singleton) >> Maybe.withDefault []


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser
