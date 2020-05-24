module Main exposing (main)

import Api
import Api.Mutation
import Api.Object.Token
import Browser exposing (Document)
import Element exposing (..)
import Element.Button as Button
import Element.Input as Input
import Element.Scale as Scale
import Element.Text as Text
import Html exposing (Html)



-- Program


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- Model


type alias Model =
    { inputs : Inputs
    , token : Maybe Token
    }


type alias Inputs =
    { email : String
    , username : String
    , password : String
    }


type Msg
    = InputsChanged Inputs
    | SignupClicked
    | SignupResponseReceived (Api.Response Token)


type alias Flags =
    ()



-- Init


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel flags, Cmd.none )


initialModel : Flags -> Model
initialModel _ =
    { inputs = emptyInputs
    , token = Nothing
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
            ( { model | token = Just token }, Cmd.none )

        SignupResponseReceived (Err _) ->
            ( model, Cmd.none )


signUp inputs =
    Api.Mutation.signup inputs Api.Object.Token.token
        |> Api.mutate SignupResponseReceived


type alias Token =
    String



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Document Msg
view model =
    { title = "App"
    , body = [ page model ]
    }


page : Model -> Html Msg
page model =
    layout []
        (column [ width fill ]
            [ navbar
            , signup model
            ]
        )


signup model =
    el [ constrain, paddingXY Scale.medium 0, centerX ]
        (column
            [ paddingXY 0 Scale.large
            , spacing Scale.large
            , width fill
            ]
            [ Text.title [ centerX ] "Sign Up"
            , column
                [ centerX
                , width (fill |> maximum (maxPageWidth // 2))
                , spacing Scale.medium
                ]
                [ username model.inputs
                , email model.inputs
                , password model.inputs
                , el [ alignRight ] signupButton
                , viewToken model
                ]
            ]
        )


viewToken model =
    model.token
        |> Maybe.map (\t -> el [] (text ("Erhmagerrd terrkerrn!: " ++ t)))
        |> Maybe.withDefault none


signupButton =
    Button.primary SignupClicked "Sign Up"
        |> Button.toElement


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


navbar =
    el
        [ centerX
        , constrain
        , paddingXY Scale.medium 0
        ]
        (row [ width fill ]
            [ Text.subtitle [ paddingXY 0 Scale.medium ] "conduit"
            , navItems
            ]
        )


navItems =
    row [ alignRight, spacing Scale.medium ]
        [ Text.link [] "Home"
        , Text.link [] "Sign In"
        , Text.link [] "Sign Up"
        ]


constrain =
    width (fill |> maximum maxPageWidth)


maxPageWidth =
    1110
