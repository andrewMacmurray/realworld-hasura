module Page.SignIn exposing
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
import Form.View.Field as Field
import Route
import User exposing (User)



-- Model


type alias Model =
    { inputs : Inputs
    , request : SignInRequest
    }


type Msg
    = InputsChanged Inputs
    | SignInClicked
    | SignInResponseReceived (Api.Response User.Profile)


type SignInRequest
    = Idle
    | InProgress
    | Failed String


type alias Inputs =
    { username : String
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
    { username = ""
    , password = ""
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        InputsChanged inputs ->
            ( { model | inputs = inputs }, Effect.none )

        SignInClicked ->
            ( { model | request = InProgress }, signIn model.inputs )

        SignInResponseReceived (Ok profile) ->
            ( model
            , Effect.batch
                [ Effect.redirectHome
                , Effect.loadUser profile
                ]
            )

        SignInResponseReceived (Err err) ->
            ( { model | request = Failed (Api.errorMessage err) }, Effect.none )


signIn : Inputs -> Effect Msg
signIn inputs =
    Api.Users.signIn inputs SignInResponseReceived



-- View


view : Model -> Element Msg
view model =
    Layout.guest
        |> Layout.halfWidth
        |> Layout.toPage (signup model)


signup : Model -> Element Msg
signup model =
    column
        [ paddingXY 0 Scale.large
        , spacing Scale.large
        , width fill
        ]
        [ el [ centerX ] (Text.title [] "Sign In")
        , el [ centerX ] (Route.link Route.SignUp [ Text.green ] "Need an Account?")
        , column [ spacing Scale.medium, width fill ]
            [ username model.inputs
            , password model.inputs
            , el [ alignRight ] signInButton
            , el [ alignRight ] (statusMessage model.request)
            ]
        ]


statusMessage : SignInRequest -> Element msg
statusMessage request =
    case request of
        Idle ->
            none

        InProgress ->
            Text.fadeIn (Text.text [] "Signing In")

        Failed reason ->
            Text.error [] reason


signInButton : Element Msg
signInButton =
    Button.button SignInClicked "Sign In"
        |> Button.primary
        |> Button.toElement


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
    Field.toElement InputsChanged << Field.medium << Field.field
