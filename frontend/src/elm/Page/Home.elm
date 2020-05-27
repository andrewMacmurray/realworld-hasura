module Page.Home exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Effect exposing (Effect)
import Element exposing (Element)
import Element.Layout as Layout
import Element.Text as Text
import User exposing (User(..))



-- Model


type alias Model =
    {}


type Msg
    = NoOp



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel, Effect.none )


initialModel : Model
initialModel =
    {}



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Effect.none )



-- View


view : User -> Model -> Element Msg
view user _ =
    case user of
        Guest ->
            Layout.guest
                [ Text.title [] "Home"
                ]

        LoggedIn profile ->
            Layout.loggedIn profile
                [ Text.title [] "Your Posts"
                ]
