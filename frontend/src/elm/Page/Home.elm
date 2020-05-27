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
import Element.Layout as Layout
import Element.Text as Text
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


globalFeed model =
    case model.globalFeed of
        WebData.Loading ->
            column [ Anchor.description "global-feed" ]
                [ Text.title [] "Global Feed"
                ]

        WebData.Loaded feed ->
            column [ Anchor.description "global-feed" ]
                [ Text.title [] "Global Feed"
                , column [] (List.map viewArticle feed)
                ]

        WebData.Failure ->
            column [ Anchor.description "global-feed" ]
                [ Text.title [] "Something went wrong"
                ]


viewArticle article =
    column [ Anchor.description "article" ]
        [ Text.subtitle [] (Article.title article)
        ]
