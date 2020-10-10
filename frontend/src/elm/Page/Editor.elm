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
import Article exposing (Article)
import Article.Component.Feed as Feed
import Context exposing (Context)
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
    { inputs : Api.Data Inputs
    , mode : Mode
    , errorsVisible : Bool
    }


type Msg
    = LoadArticleResponseReceived (Api.Response (Maybe Article))
    | InputsChanged Inputs
    | PublishClickedWithErrors
    | PublishClicked Article.Inputs
    | PublishResponseReceived (Api.Response ())
    | EditResponseReceived Article.Id (Api.Response ())


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
    case mode of
        NewArticle ->
            ( initialModel mode (Api.Success emptyInputs), Effect.none )

        EditArticle id ->
            ( initialModel mode Api.Loading, loadArticle id )


initialModel : Mode -> Api.Data Inputs -> Model
initialModel mode inputs =
    { inputs = inputs
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


loadArticle : Article.Id -> Effect Msg
loadArticle id =
    Api.Articles.loadArticle id LoadArticleResponseReceived



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LoadArticleResponseReceived response ->
            ( { model | inputs = Api.mapData toInputs (Api.fromNullableResponse response) }
            , Effect.none
            )

        InputsChanged inputs ->
            ( { model | inputs = Api.Success inputs }, Effect.none )

        PublishClicked toCreate ->
            ( model, publishArticle model.mode toCreate )

        PublishResponseReceived (Ok _) ->
            ( model, Effect.redirectHome )

        PublishResponseReceived (Err _) ->
            ( model, Effect.none )

        PublishClickedWithErrors ->
            ( { model | errorsVisible = True }, Effect.none )

        EditResponseReceived id (Ok _) ->
            ( model, Effect.goToArticle id )

        EditResponseReceived _ (Err _) ->
            ( model, Effect.none )


toInputs : Article -> Inputs
toInputs article =
    { title = Article.title article
    , about = Article.about article
    , content = Article.content article
    , tags = tagsToString article
    }


tagsToString : Article -> String
tagsToString =
    Article.tags >> List.map Tag.value >> String.join " "


publishArticle : Mode -> Article.Inputs -> Effect Msg
publishArticle mode =
    case mode of
        NewArticle ->
            Api.Articles.publish PublishResponseReceived

        EditArticle id ->
            Api.Articles.edit (EditResponseReceived id) id



-- View


view : User.Profile -> Context -> Model -> Element Msg
view user context model =
    Layout.layout
        |> Layout.measured
        |> Layout.authenticated user context (page model)


page : Model -> Element Msg
page model =
    case model.inputs of
        Api.Loading ->
            el [ paddingXY 0 (Scale.large + Scale.extraSmall) ] Feed.loadingMessage

        Api.NotFound ->
            Text.text [] "No article found"

        Api.Failure ->
            Text.error [] "Error loading article"

        Api.Success inputs_ ->
            page_ inputs_ model


page_ : Inputs -> Model -> Element Msg
page_ inputs model =
    column
        [ width fill
        , spacing Scale.medium
        , paddingXY 0 Scale.large
        ]
        [ title inputs model
        , about inputs model
        , content inputs model
        , tags inputs
        , showTags inputs.tags
        , publishButton inputs model
        ]


publishButton : Inputs -> Model -> Element Msg
publishButton inputs model =
    el [ alignRight ] (publishButton_ inputs model)


publishButton_ : Inputs -> Model -> Element Msg
publishButton_ inputs model =
    Button.validateOnSubmit
        { label = "Publish Article"
        , validation = validation inputs
        , inputs = inputs
        , showError = model.errorsVisible
        , onSubmit = PublishClicked
        , onError = PublishClickedWithErrors
        }


validation : Inputs -> Validation Inputs Article.Inputs
validation inputs =
    Validation.build Article.Inputs
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


title : Inputs -> Model -> Element Msg
title inputs model =
    title_
        |> Field.large
        |> validate inputs model
        |> textInput inputs


about : Inputs -> Model -> Element Msg
about inputs model =
    about_
        |> Field.small
        |> validate inputs model
        |> textInput inputs


content : Inputs -> Model -> Element Msg
content inputs model =
    content_
        |> Field.area
        |> validate inputs model
        |> textInput inputs


tags : Inputs -> Element Msg
tags inputs =
    tags_
        |> Field.small
        |> textInput inputs


validate : Inputs -> Model -> Field.View Inputs Article.Inputs -> Field.View Inputs Article.Inputs
validate inputs model =
    Field.validateWith (validation inputs) >> Field.showErrorsIf model.errorsVisible



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
