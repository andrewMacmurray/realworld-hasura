module Page.Signup exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Users
import Context exposing (Context)
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


view : Context -> Model -> Element Msg
view context model =
    Layout.layout
        |> Layout.halfWidth
        |> Layout.toPage context (signup model)


signup : Model -> Element Msg
signup model =
    column
        [ paddingXY 0 Scale.large
        , spacing Scale.large
        , width fill
        ]
        [ el [ centerX ] (Text.title [] "Sign Up")
        , el [ centerX ] (Route.link Route.SignIn [ Text.green ] "Have an Account already?")
        , column [ width fill, spacing Scale.medium ]
            [ username model.inputs
            , email model.inputs
            , password model.inputs
            , column [ alignRight, spacing Scale.small ]
                [ el [ alignRight ] (signupButton model.request)
                , el [ alignRight ] (statusMessage model.request)
                ]
            ]
        ]


statusMessage : SignUpRequest -> Element msg
statusMessage request =
    case request of
        Idle ->
            none

        InProgress ->
            Text.fadeIn (Text.text [] "Signing Up")

        Failed reason ->
            Text.error [] reason


signupButton : SignUpRequest -> Element Msg
signupButton request =
    case request of
        InProgress ->
            Button.decorative "Sign Up"
                |> Button.primary
                |> Button.loading
                |> Button.toElement

        _ ->
            Button.button SignupClicked "Sign Up"
                |> Button.primary
                |> Button.toElement


email : Inputs -> Element Msg
email =
    input Field.medium
        { label = "Email"
        , value = .email
        , update = \i v -> { i | email = v }
        }


username : Inputs -> Element Msg
username =
    input Field.medium
        { label = "Username"
        , value = .username
        , update = \i v -> { i | username = v }
        }


password : Inputs -> Element Msg
password =
    input Field.newPassword
        { label = "Password"
        , value = .password
        , update = \i v -> { i | password = v }
        }


input : (Field.Field inputs -> Field.View Inputs output) -> Field.Config inputs -> Inputs -> Element Msg
input withStyle =
    Field.field >> withStyle >> Field.toElement InputsChanged
