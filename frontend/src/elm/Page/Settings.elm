module Page.Settings exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Users
import Effect exposing (Effect)
import Element exposing (..)
import Element.Divider as Divider
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import Form
import Form.Field as Field exposing (Field)
import Form.Validation as Validation exposing (Validation)
import Form.View.Field as Field
import User exposing (SettingsUpdate, User(..))



-- Model


type alias Model =
    { inputs : Inputs
    }


type Msg
    = InputsChanged Inputs
    | UpdateSettingsClicked User.SettingsUpdate
    | UpdateSettingsResponseReceived User.SettingsUpdate (Api.Response ())


type alias Inputs =
    { username : String
    , email : String
    , bio : String
    , profileImage : String
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
    , bio = defaultToEmpty (User.bio profile)
    , profileImage = defaultToEmpty (User.profileImage profile)
    }


defaultToEmpty : Maybe String -> String
defaultToEmpty =
    Maybe.withDefault ""



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        InputsChanged inputs ->
            ( { model | inputs = inputs }, Effect.none )

        UpdateSettingsClicked settingsUpdate ->
            ( model, updateSettings settingsUpdate )

        UpdateSettingsResponseReceived settings (Ok _) ->
            ( model, Effect.updateSettings settings )

        UpdateSettingsResponseReceived _ (Err _) ->
            ( model, Effect.none )


updateSettings : SettingsUpdate -> Effect Msg
updateSettings settings =
    Api.Users.update settings (UpdateSettingsResponseReceived settings)



-- View


view : User.Profile -> Model -> Element Msg
view user model =
    Layout.authenticated user
        |> Layout.halfWidth
        |> Layout.toPage
            (column [ spacing Scale.large, width fill ]
                [ el [ centerX ] (Text.title [ Text.description "settings-title" ] "Your Settings")
                , settingsFields user model
                ]
            )


settingsFields : User.Profile -> Model -> Element Msg
settingsFields profile model =
    column [ width fill, spacing Scale.medium ]
        [ profileImage profile model.inputs
        , username profile model.inputs
        , email profile model.inputs
        , bio profile model.inputs
        , Divider.divider
        , updateButton profile model
        ]


updateButton : User.Profile -> Model -> Element Msg
updateButton profile model =
    Form.button
        { label = "Update Settings"
        , validation = validation profile
        , inputs = model.inputs
        , onSubmit = UpdateSettingsClicked
        }


email profile =
    textField profile Field.small email_


username profile =
    textField profile Field.small username_


profileImage profile =
    textField profile Field.small profileImage_


bio : User.Profile -> Inputs -> Element Msg
bio profile =
    textField profile Field.area bio_


textField profile style field =
    style field
        |> Field.validateWith (validation profile)
        |> Field.toElement InputsChanged



-- Validation


validation : User.Profile -> Validation Inputs SettingsUpdate
validation profile_ =
    Validation.build User.settingsUpdate
        |> Validation.constant (User.id profile_)
        |> Validation.nonEmpty username_
        |> Validation.nonEmpty email_
        |> Validation.optional bio_
        |> Validation.optional profileImage_



-- Fields


email_ : Field Inputs
email_ =
    Field.field
        { value = .email
        , update = \i v -> { i | email = v }
        , label = "Email"
        }


username_ : Field Inputs
username_ =
    Field.field
        { value = .username
        , update = \i v -> { i | username = v }
        , label = "Username"
        }


profileImage_ : Field Inputs
profileImage_ =
    Field.field
        { value = .profileImage
        , update = \i v -> { i | profileImage = v }
        , label = "Profile Image Url"
        }


bio_ : Field Inputs
bio_ =
    Field.field
        { value = .bio
        , update = \i v -> { i | bio = v }
        , label = "A short bio about you"
        }
