module Page.Signup exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

-- Model

import Api
import Api.Mutation
import Api.Object.Token
import Element exposing (..)
import Element.Button as Button
import Element.Input as Input
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text



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


init : Model
init =
    initialModel


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputsChanged inputs ->
            ( { model | inputs = inputs }, Cmd.none )

        SignupClicked ->
            ( model, signUp model.inputs )

        SignupResponseReceived (Ok token) ->
            ( model, Cmd.none )

        SignupResponseReceived (Err _) ->
            ( model, Cmd.none )


signUp inputs =
    Api.Mutation.signup inputs Api.Object.Token.token
        |> Api.mutate SignupResponseReceived



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
    Input.text []
        { onChange = config.update inputs >> InputsChanged
        , text = config.value inputs
        , placeholder = Just (Input.placeholder [] (text config.label))
        , label = Input.labelHidden config.label
        }
