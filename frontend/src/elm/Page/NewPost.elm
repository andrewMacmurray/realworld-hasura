module Page.NewPost exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Font as Font
import Element.Layout as Layout
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import Form.Field as Field
import Tags exposing (Tag)
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
    , tags : String
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
    , tags = ""
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
                , tags model.inputs
                , showTags model.inputs.tags
                ]
            )
        ]


showTags : String -> Element msg
showTags =
    Tags.fromString
        >> List.map showTag
        >> wrappedRow [ spacing Scale.small ]


showTag : Tag -> Element msg
showTag tag_ =
    Text.text [ Font.color Palette.green, Anchor.description "visible-tag" ] ("#" ++ Tags.value tag_)


title : Inputs -> Element Msg
title =
    textInput Field.large
        { value = .title
        , update = \i v -> { i | title = v }
        , label = "Article Title"
        }


about : Inputs -> Element Msg
about =
    textInput Field.small
        { value = .about
        , update = \i v -> { i | about = v }
        , label = "What's this article about?"
        }


content : Inputs -> Element Msg
content =
    textInput Field.area
        { value = .content
        , update = \i v -> { i | content = v }
        , label = "Write your article (in markdown)"
        }


tags : Inputs -> Element Msg
tags =
    textInput Field.small
        { value = .tags
        , update = \i v -> { i | tags = v }
        , label = "Enter tags"
        }


textInput : Field.Style -> Field.Config Inputs -> Inputs -> Element Msg
textInput =
    Field.text InputsChanged
