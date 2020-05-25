module Page.Home exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Element exposing (Element)
import Element.Layout as Layout
import Element.Text as Text



-- Model


type alias Model =
    {}


type Msg
    = NoOp



-- Init


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    {}



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- View


view : Model -> Element Msg
view _ =
    Layout.page
        [ Text.title [] "Home"
        ]
