module Route exposing
    ( Route(..)
    , author
    , button
    , editArticle
    , el
    , fromUrl
    , home
    , link
    , profile
    , routeToString
    , tagFeed
    )

import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Article.Page as Page
import Element exposing (Element)
import Element.Button as Button exposing (Button)
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
    | NewArticle
    | EditArticle Article.Id
    | Settings
    | Article Article.Id
    | Author User.Id
    | Logout


parser : Parser.Parser (Route -> c) c
parser =
    oneOf
        [ Parser.map Home (top <?> tagQuery)
        , Parser.map SignUp (s "sign-up")
        , Parser.map SignIn (s "sign-in")
        , Parser.map NewArticle (s "new-article")
        , Parser.map Article (s "article" </> int)
        , Parser.map EditArticle (s "article" </> s "edit" </> int)
        , Parser.map Settings (s "settings")
        , Parser.map Author (s "author" </> int)
        , Parser.map Logout (s "logout")
        ]


tagFeed : Tag -> Route
tagFeed tag =
    Home (Just tag)


home : Route
home =
    Home Nothing


editArticle : Article -> Route
editArticle =
    Article.id >> EditArticle


author : Author -> Route
author a =
    Author (Author.id a)


profile : User.Profile -> Route
profile p =
    Author (User.id p)


tagQuery : Query.Parser (Maybe Tag)
tagQuery =
    Query.string "tag" |> Query.map (Maybe.map Tag.one)


pageNumber : Query.Parser Page.Number
pageNumber =
    Query.int "page" |> Query.map Page.toNumber


link : Route -> List Text.Option -> String -> Element msg
link route options label =
    el route (Text.link (options ++ [ Text.description (label ++ "-link") ]) label)


button : Route -> String -> Button msg
button route text =
    Button.link
        { href = routeToString route
        , text = text
        }


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

        NewArticle ->
            absolute [ "new-article" ] []

        EditArticle id ->
            absolute [ "article", "edit", String.fromInt id ] []

        Settings ->
            absolute [ "settings" ] []

        Article id ->
            absolute [ "article", String.fromInt id ] []

        Author id ->
            absolute [ "author", String.fromInt id ] []

        Logout ->
            absolute [ "logout" ] []


toTagQuery_ : Maybe Tag -> List Url.QueryParameter
toTagQuery_ =
    Maybe.map (Tag.value >> Url.string "tag" >> List.singleton) >> Maybe.withDefault []


fromUrl : Url -> Maybe Route
fromUrl =
    Parser.parse parser
