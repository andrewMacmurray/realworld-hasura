module Page.Signup exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Mutation
import Api.Object.Token
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Button as Button
import Element.Input as Input
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import Route



-- Model


type alias Model =
    { inputs : Inputs
    }


type Msg
    = InputsChanged Inputs
    | SignupClicked
    | SignupResponseReceived (Api.Response Token)


type alias Inputs =
    { email : String
    , username : String
    , password : String
    }


type alias Token =
    String



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel, Effect.none )


initialModel : Model
initialModel =
    { inputs = emptyInputs
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
            ( model, signUp model.inputs )

        SignupResponseReceived (Ok _) ->
            ( model, Effect.navigateTo Route.Home )

        SignupResponseReceived (Err _) ->
            ( model, Effect.none )


signUp : Api.Mutation.SignupRequiredArguments -> Effect Msg
signUp inputs =
    Api.Mutation.signup inputs Api.Object.Token.token
        |> Effect.signup SignupResponseReceived



-- View


view : Model -> Element Msg
view model =
    Layout.page
        [ signup model
        ]


signup : Model -> Element Msg
signup model =
    column
        [ paddingXY 0 Scale.large
        , spacing Scale.large
        , width fill
        ]
        [ Text.title [ centerX ] "Sign Up"
        , column
            [ centerX
            , width (fill |> maximum (Layout.maxWidth // 2))
            , spacing Scale.medium
            ]
            [ username model.inputs
            , email model.inputs
            , password model.inputs
            , el [ alignRight ] signupButton
            ]
        ]


signupButton : Element Msg
signupButton =
    Button.primary SignupClicked "Sign Up"


email =
    textInput
        { label = "Email"
        , value = .email
        , update = \i v -> { i | email = v }
        }


username =
    textInput
        { label = "Username"
        , value = .username
        , update = \i v -> { i | username = v }
        }


password =
    textInput
        { label = "Password"
        , value = .password
        , update = \i v -> { i | password = v }
        }


textInput config inputs =
    Input.text [ Anchor.description config.label ]
        { onChange = config.update inputs >> InputsChanged
        , text = config.value inputs
        , placeholder = Just (Input.placeholder [] (text config.label))
        , label = Input.labelHidden config.label
        }
