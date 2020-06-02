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
import Form.Field as Field
import User exposing (User(..))



-- Model


type alias Model =
    { inputs : Inputs
    }


type Msg
    = LogoutClicked
    | InputsChanged Inputs


type alias Inputs =
    { username : String
    , email : String
    }



-- Init


init : User.Profile -> ( Model, Effect Msg )
init profile =
    ( initialModel profile, Effect.None )


initialModel : User.Profile -> Model
initialModel profile =
    { inputs = initInputs profile }


initInputs : User.Profile -> Inputs
initInputs profile =
    { username = User.username profile
    , email = User.email profile
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LogoutClicked ->
            ( model, Effect.logout )

        InputsChanged inputs ->
            ( { model | inputs = inputs }, Effect.none )



-- View


view : User.Profile -> Model -> Element Msg
view user model =
    Layout.authenticated user
        |> Layout.toElement
            [ column [ spacing Scale.medium, width fill, paddingXY 0 Scale.large ]
                [ el [ centerX ] (Text.title [ Text.description "settings-title" ] "Your Settings")
                , settingsFields model
                ]
            ]


settingsFields : Model -> Element Msg
settingsFields model =
    Layout.halfWidth
        (column [ width fill, spacing Scale.medium ]
            [ username model.inputs
            , email model.inputs
            , Divider.divider
            , el [ Anchor.description "logout" ] (Button.secondary LogoutClicked "Logout")
            ]
        )


email : Inputs -> Element Msg
email =
    textField
        { value = .email
        , update = \i v -> { i | email = v }
        , label = "Email"
        }


username : Inputs -> Element Msg
username =
    textField
        { value = .username
        , update = \i v -> { i | username = v }
        , label = "Username"
        }


textField : Field.Config Inputs -> Inputs -> Element Msg
textField =
    Field.text InputsChanged Field.small
