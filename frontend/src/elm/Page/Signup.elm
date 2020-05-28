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

        SignupResponseReceived (Ok token) ->
            ( model
            , Effect.batch
                [ Effect.saveToken token
                , Effect.navigateTo Route.Home
                ]
            )

        SignupResponseReceived (Err _) ->
            ( model, Effect.none )


signUp : Inputs -> Effect Msg
signUp inputs =
    Api.Users.signUp inputs SignupResponseReceived



-- View


view : Model -> Element Msg
view model =
    Layout.guest
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
        , Layout.halfWidth
            (column [ width fill, spacing Scale.medium ]
                [ username model.inputs
                , email model.inputs
                , password model.inputs
                , el [ alignRight ] signupButton
                ]
            )
        ]


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


textInput config inputs =
    Input.text [ Anchor.description config.label ]
        { onChange = config.update inputs >> InputsChanged
        , text = config.value inputs
        , placeholder = Just (Input.placeholder [] (text config.label))
        , label = Input.labelHidden config.label
        }
