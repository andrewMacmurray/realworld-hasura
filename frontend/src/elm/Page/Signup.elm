module Page.Signup exposing
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
import Element.Button as Button
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import Form.Field as Field
import Route
import User exposing (User)



-- Model


type alias Model =
    { inputs : Inputs
    , request : SignUpRequest
    }


type Msg
    = InputsChanged Inputs
    | SignupClicked
    | SignupResponseReceived (Api.Response User.Profile)


type SignUpRequest
    = Idle
    | InProgress
    | Failed String


type alias Inputs =
    { email : String
    , username : String
    , password : String
    }



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel, Effect.none )


initialModel : Model
initialModel =
    { inputs = emptyInputs
    , request = Idle
    }


emptyInputs : Inputs
emptyInputs =
    { email = ""
    , username = ""
    , password = ""
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        InputsChanged inputs ->
            ( { model | inputs = inputs }, Effect.none )

        SignupClicked ->
            ( { model | request = InProgress }, signUp model.inputs )

        SignupResponseReceived (Ok res) ->
            ( model
            , Effect.batch
                [ Effect.loadUser res
                , Effect.redirectHome
                ]
            )

        SignupResponseReceived (Err err) ->
            ( { model | request = Failed (Api.errorMessage err) }, Effect.none )


signUp : Inputs -> Effect Msg
signUp inputs =
    Api.Users.signUp inputs SignupResponseReceived



-- View


view : Model -> Element Msg
view model =
    Layout.guest |> Layout.toElement [ signup model ]


signup : Model -> Element Msg
signup model =
    column
        [ paddingXY 0 Scale.large
        , spacing Scale.large
        , width fill
        ]
        [ el [ centerX ] (Text.title [] "Sign Up")
        , el [ centerX ] (Route.link Route.SignIn "Have an Account already?")
        , Layout.halfWidth
            (column [ width fill, spacing Scale.medium ]
                [ username model.inputs
                , email model.inputs
                , password model.inputs
                , el [ alignRight ] signupButton
                , el [ alignRight ] (statusMessage model.request)
                ]
            )
        ]


statusMessage : SignUpRequest -> Element msg
statusMessage request =
    case request of
        Idle ->
            none

        InProgress ->
            Text.text [] "Signing Up"

        Failed reason ->
            Text.error [] reason


signupButton : Element Msg
signupButton =
    Button.primary SignupClicked "Sign Up"


email : Inputs -> Element Msg
email =
    textInput
        { label = "Email"
        , value = .email
        , update = \i v -> { i | email = v }
        }


username : Inputs -> Element Msg
username =
    textInput
        { label = "Username"
        , value = .username
        , update = \i v -> { i | username = v }
        }


password : Inputs -> Element Msg
password =
    textInput
        { label = "Password"
        , value = .password
        , update = \i v -> { i | password = v }
        }


textInput : Field.Config Inputs -> Inputs -> Element Msg
textInput =
    Field.text InputsChanged Field.medium
