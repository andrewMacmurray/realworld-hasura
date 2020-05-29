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
import Element.Divider as Divider
import Element.Layout as Layout
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
    case user of
        Guest ->
            Layout.guest [ globalFeed model ]

        LoggedIn profile ->
            Layout.loggedIn profile [ globalFeed model ]


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
        , paddingXY 0 Scale.large
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
        , column [ spacing Scale.small ]
            [ Text.greenLink [] (Article.author article)
            , Text.date [] (Article.createdAt article)
            ]
        , Route.el (Route.Article (Article.id article))
            (column [ spacing Scale.small ]
                [ Text.subtitle [] (Article.title article)
                , Text.text [] (Article.about article)
                ]
            )
        , Text.label [] "Read more..."
        ]
