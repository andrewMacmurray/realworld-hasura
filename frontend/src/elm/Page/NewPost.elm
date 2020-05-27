module Page.NewPost exposing
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
    ( initialModel, Effect.None )


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


view : User.Profile -> Model -> Element Msg
view user _ =
    Layout.loggedIn user
        [ Text.title [] "New Post"
        ]
