module Page.Home exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Article exposing (Article)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Divider as Divider
import Element.Font as Font
import Element.Layout as Layout
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import Route
import User exposing (User(..))
import WebData exposing (WebData)



-- Model


type alias Model =
    { globalFeed : WebData (List Article)
    }


type Msg
    = GlobalFeedResponseReceived (Api.Response (List Article))



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel
    , Api.Articles.globalFeed GlobalFeedResponseReceived
    )


initialModel : Model
initialModel =
    { globalFeed = WebData.Loading
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GlobalFeedResponseReceived response ->
            ( { model | globalFeed = WebData.fromResult response }, Effect.none )



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> Layout.withBanner [ Background.color Palette.green ] banner
        |> Layout.toElement [ globalFeed model ]


banner : Element msg
banner =
    column [ spacing Scale.medium, centerX ]
        [ Text.headline [ Font.color Palette.white, centerX ] "conduit"
        , Text.subtitle [ Font.color Palette.white, Font.regular, centerX ] "A place to share your knowledge"
        ]


globalFeed : Model -> Element msg
globalFeed model =
    case model.globalFeed of
        WebData.Loading ->
            feed (Text.text [] "Loading")

        WebData.Success feed_ ->
            feed (column [ spacing Scale.large, width fill ] (List.map viewArticle feed_))

        WebData.Failure ->
            feed (Text.text [] "Something Went wrong")


feed : Element msg -> Element msg
feed contents =
    column
        [ Anchor.description "global-feed"
        , width fill
        , spacing Scale.large
        ]
        [ Text.greenLink [] "Global Feed"
        , contents
        ]


viewArticle : Article -> Element msg
viewArticle article =
    column
        [ Anchor.description "article"
        , spacing Scale.medium
        , width fill
        ]
        [ Divider.divider
        , row [ spacing Scale.small ]
            [ Avatar.large (Article.profileImage article)
            , column [ spacing Scale.small ]
                [ Text.greenLink [] (Article.author article)
                , Text.date [] (Article.createdAt article)
                ]
            ]
        , linkToArticle article
            (column [ spacing Scale.small ]
                [ Text.subtitle [] (Article.title article)
                , Text.text [] (Article.about article)
                ]
            )
        , linkToArticle article (Text.label [] "Read more...")
        ]


linkToArticle : Article -> Element msg -> Element msg
linkToArticle =
    Article.id >> Route.Article >> Route.el
