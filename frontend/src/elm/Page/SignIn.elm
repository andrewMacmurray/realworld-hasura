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
import Route
import User exposing (User)



-- Model


type alias Model =
    { inputs : Inputs
    }


type Msg
    = InputsChanged Inputs
    | SignInClicked
    | SignInResponseReceived (Api.Response User.Profile)


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
            ( model, signIn model.inputs )

        SignInResponseReceived (Ok profile) ->
            ( model
            , Effect.batch
                [ Effect.navigateTo Route.Home
                , Effect.loadUser profile
                ]
            )

        SignInResponseReceived (Err _) ->
            ( model, Effect.none )


signIn : Inputs -> Effect Msg
signIn inputs =
    Api.Users.signIn inputs SignInResponseReceived



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
        [ Text.title [ centerX ] "Sign In"
        , Layout.halfWidth
            (column [ spacing Scale.medium, width fill ]
                [ username model.inputs
                , password model.inputs
                , el [ alignRight ] signInButton
                ]
            )
        ]


signInButton : Element Msg
signInButton =
    Button.primary SignInClicked "Sign In"


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
    Field.text InputsChanged
