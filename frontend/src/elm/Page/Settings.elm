module Page.Settings exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Button as Button
import Element.Divider as Divider
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import User exposing (User(..))



-- Model


type alias Model =
    {}


type Msg
    = LogoutClicked



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel, Effect.None )


initialModel : Model
initialModel =
    {}



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LogoutClicked ->
            ( model, Effect.logout )



-- View


view : User.Profile -> Model -> Element Msg
view user _ =
    Layout.loggedIn user
        [ column [ spacing Scale.medium, width fill, paddingXY 0 Scale.large ]
            [ Text.title [ Anchor.description "settings-title", centerX ] "Your Settings"
            , settingsFields
            ]
        ]


settingsFields : Element Msg
settingsFields =
    Layout.halfWidth
        (column [ width fill, spacing Scale.medium ]
            [ Divider.divider
            , el [ Anchor.description "logout" ] (Button.secondary LogoutClicked "Logout")
            ]
        )
