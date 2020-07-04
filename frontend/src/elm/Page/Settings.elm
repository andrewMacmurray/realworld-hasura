module Page.Settings exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Effect exposing (Effect)
import Element exposing (..)
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
        LogoutClicked ->
            ( model, Effect.logout )

        InputsChanged inputs ->
            ( { model | inputs = inputs }, Effect.none )



-- View


view : User.Profile -> Model -> Element Msg
view user model =
    Layout.authenticated user
        |> Layout.halfWidth
        |> Layout.toPage
            (column [ spacing Scale.large, width fill ]
                [ el [ centerX ] (Text.title [ Text.description "settings-title" ] "Your Settings")
                , settingsFields model
                ]
            )


settingsFields : Model -> Element Msg
settingsFields model =
    column [ width fill, spacing Scale.medium ]
        [ profileImage model.inputs
        , username model.inputs
        , email model.inputs
        , bio model.inputs
        , Divider.divider
        , logout
        ]


logout : Element Msg
logout =
    Button.button LogoutClicked "Logout"
        |> Button.secondary
        |> Button.description "logout"
        |> Button.toElement


email : Inputs -> Element Msg
email =
    textField Field.small
        { value = .email
        , update = \i v -> { i | email = v }
        , label = "Email"
        }


username : Inputs -> Element Msg
username =
    textField Field.small
        { value = .username
        , update = \i v -> { i | username = v }
        , label = "Username"
        }


profileImage : Inputs -> Element Msg
profileImage =
    textField Field.small
        { value = .profileImage
        , update = \i v -> { i | profileImage = v }
        , label = "Profile Image Url"
        }


bio : Inputs -> Element Msg
bio =
    textField Field.area
        { value = .bio
        , update = \i v -> { i | bio = v }
        , label = "A short bio about you"
        }


textField : Field.Style -> Field.Config Inputs -> Inputs -> Element Msg
textField =
    Field.text InputsChanged
