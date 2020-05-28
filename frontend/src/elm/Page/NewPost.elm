module Page.NewPost exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Effect exposing (Effect)
import Element exposing (..)
import Element.Layout as Layout
import Element.Scale as Scale
import Form.Field as Field
import User exposing (User(..))



-- Model


type alias Model =
    { inputs : Inputs
    }


type Msg
    = InputsChanged Inputs


type alias Inputs =
    { title : String
    , about : String
    , content : String
    }



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel, Effect.none )


initialModel : Model
initialModel =
    { inputs = emptyInputs }


emptyInputs : Inputs
emptyInputs =
    { title = ""
    , about = ""
    , content = ""
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        InputsChanged inputs ->
            ( { model | inputs = inputs }, Effect.none )



-- View


view : User.Profile -> Model -> Element Msg
view user model =
    Layout.loggedIn user
        [ Layout.padded
            (column
                [ width fill
                , spacing Scale.medium
                , paddingXY 0 Scale.large
                ]
                [ title model.inputs
                , about model.inputs
                , content model.inputs
                ]
            )
        ]


title =
    textInput Field.large
        { value = .title
        , update = \i v -> { i | title = v }
        , label = "Article Title"
        }


about =
    textInput Field.small
        { value = .about
        , update = \i v -> { i | about = v }
        , label = "What's this article about?"
        }


content =
    textInput Field.area
        { value = .content
        , update = \i v -> { i | content = v }
        , label = "Write your article (in Markdown)"
        }


textInput =
    Field.text InputsChanged
