module Page.NewPost exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Article
import Effect exposing (Effect)
import Element exposing (..)
import Element.Button as Button
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import Form.Field as Field
import Form.View.Field as Field
import Tag exposing (Tag)
import User exposing (User(..))



-- Model


type alias Model =
    { inputs : Inputs
    }


type Msg
    = InputsChanged Inputs
    | PublishClicked
    | PublishResponseReceived (Api.Response ())


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

        PublishClicked ->
            ( model, publishArticle model.inputs )

        PublishResponseReceived (Ok _) ->
            ( model, Effect.redirectHome )

        PublishResponseReceived (Err _) ->
            ( model, Effect.none )


publishArticle : Inputs -> Effect Msg
publishArticle =
    Article.toCreate >> Api.Articles.publish PublishResponseReceived



-- View


view : User.Profile -> Model -> Element Msg
view user model =
    Layout.authenticated user
        |> Layout.measured
        |> Layout.toPage
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
                , publishButton
                ]
            )


publishButton : Element Msg
publishButton =
    el [ alignRight ]
        (Button.button PublishClicked "Publish Article"
            |> Button.primary
            |> Button.toElement
        )


showTags : String -> Element msg
showTags =
    Tag.parse
        >> List.map showTag
        >> wrappedRow [ spacing Scale.small ]


showTag : Tag -> Element msg
showTag tag_ =
    Text.text [ Text.green, Text.description "visible-tag" ] ("#" ++ Tag.value tag_)


title : Inputs -> Element Msg
title =
    Field.field
        { value = .title
        , update = \i v -> { i | title = v }
        , label = "Article Title"
        }
        |> Field.large
        |> textInput


about : Inputs -> Element Msg
about =
    Field.field
        { value = .about
        , update = \i v -> { i | about = v }
        , label = "What's this article about?"
        }
        |> Field.small
        |> textInput


content : Inputs -> Element Msg
content =
    Field.field
        { value = .content
        , update = \i v -> { i | content = v }
        , label = "Write your article (in markdown)"
        }
        |> Field.area
        |> textInput


tags : Inputs -> Element Msg
tags =
    Field.field
        { value = .tags
        , update = \i v -> { i | tags = v }
        , label = "Enter tags"
        }
        |> Field.small
        |> textInput


textInput : Field.View Inputs -> Inputs -> Element Msg
textInput =
    Field.toElement InputsChanged
