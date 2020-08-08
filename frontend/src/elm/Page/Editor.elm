module Page.Editor exposing
    ( Mode(..)
    , Model
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
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import Form.Button as Button
import Form.Field as Field exposing (Field)
import Form.Validation as Validation exposing (Validation)
import Form.View.Field as Field
import Tag exposing (Tag)
import User exposing (User(..))



-- Model


type alias Model =
    { inputs : Inputs
    , mode : Mode
    , errorsVisible : Bool
    }


type Msg
    = InputsChanged Inputs
    | PublishClickedWithErrors
    | PublishClicked Article.ToCreate
    | PublishResponseReceived (Api.Response ())


type Mode
    = EditArticle Article.Id
    | NewArticle


type alias Inputs =
    { title : String
    , about : String
    , content : String
    , tags : String
    }



-- Init


init : Mode -> ( Model, Effect Msg )
init mode =
    ( initialModel mode, Effect.none )


initialModel : Mode -> Model
initialModel mode =
    { inputs = emptyInputs
    , mode = mode
    , errorsVisible = False
    }


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

        PublishClicked toCreate ->
            ( model, publishArticle toCreate )

        PublishResponseReceived (Ok _) ->
            ( model, Effect.redirectHome )

        PublishResponseReceived (Err _) ->
            ( model, Effect.none )

        PublishClickedWithErrors ->
            ( { model | errorsVisible = True }, Effect.none )


publishArticle : Article.ToCreate -> Effect Msg
publishArticle =
    Api.Articles.publish PublishResponseReceived



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
                [ title model
                , about model
                , content model
                , tags model.inputs
                , showTags model.inputs.tags
                , publishButton model
                ]
            )


publishButton : Model -> Element Msg
publishButton model =
    el [ alignRight ] (publishButton_ model)


publishButton_ : Model -> Element Msg
publishButton_ model =
    Button.validateOnSubmit
        { label = "Publish Article"
        , validation = validation model.inputs
        , inputs = model.inputs
        , showError = model.errorsVisible
        , onSubmit = PublishClicked
        , onError = PublishClickedWithErrors
        }


validation : Inputs -> Validation Inputs Article.ToCreate
validation inputs =
    Validation.build Article.ToCreate
        |> Validation.nonEmpty title_
        |> Validation.nonEmpty about_
        |> Validation.nonEmpty content_
        |> Validation.constant (Tag.parse inputs.tags)


showTags : String -> Element msg
showTags =
    Tag.parse
        >> List.map showTag
        >> wrappedRow [ spacing Scale.small ]


showTag : Tag -> Element msg
showTag tag_ =
    Text.text [ Text.green, Text.description "visible-tag" ] ("#" ++ Tag.value tag_)


title : Model -> Element Msg
title model =
    title_
        |> Field.large
        |> validate model
        |> textInput model.inputs


about : Model -> Element Msg
about model =
    about_
        |> Field.small
        |> validate model
        |> textInput model.inputs


content : Model -> Element Msg
content model =
    content_
        |> Field.area
        |> validate model
        |> textInput model.inputs


tags : Inputs -> Element Msg
tags inputs =
    tags_
        |> Field.small
        |> textInput inputs


validate : Model -> Field.View Inputs Article.ToCreate -> Field.View Inputs Article.ToCreate
validate model =
    Field.validateWith (validation model.inputs) >> Field.showErrorsIf model.errorsVisible



-- Fields


title_ : Field Inputs
title_ =
    Field.field
        { value = .title
        , update = \i v -> { i | title = v }
        , label = "Article Title"
        }


about_ : Field Inputs
about_ =
    Field.field
        { value = .about
        , update = \i v -> { i | about = v }
        , label = "What's this article about?"
        }


content_ : Field Inputs
content_ =
    Field.field
        { value = .content
        , update = \i v -> { i | content = v }
        , label = "Write your article (in markdown)"
        }


tags_ : Field Inputs
tags_ =
    Field.field
        { value = .tags
        , update = \i v -> { i | tags = v }
        , label = "Enter tags"
        }


textInput : Inputs -> Field.View Inputs outputs -> Element Msg
textInput inputs view_ =
    Field.toElement InputsChanged view_ inputs
