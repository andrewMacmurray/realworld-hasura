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
import Context exposing (Context)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Button as Button exposing (Button)
import Element.Layout as Layout
import Element.Loader.Conduit as Loader
import Element.Markdown as Markdown
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Form.Button as Button
import Form.Field as Field exposing (Field)
import Form.Validation as Validation exposing (Validation)
import Form.View.Field as Field
import Tag exposing (Tag)
import User exposing (User(..))
import Utils.Element exposing (wrappedRow_)



-- Model


type alias Model =
    { inputs : Api.Data Inputs
    , mode : Mode
    , request : Request
    }


type Msg
    = LoadArticleResponseReceived (Api.Response (Maybe Article))
    | InputsChanged Inputs
    | PublishClickedWithErrors Inputs
    | PublishClicked Article.Inputs
    | PublishResponseReceived (Api.Response Article.Id)
    | EditResponseReceived (Api.Response Article.Id)


type Mode
    = EditArticle Article.Id
    | NewArticle


type Request
    = Idle
    | InProgress
    | Failed String


type alias Inputs =
    { title : String
    , about : String
    , content : String
    , tags : String
    , errorsVisible : Bool
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
    , request = Idle
    , mode = mode
    }


emptyInputs : Inputs
emptyInputs =
    { title = ""
    , about = ""
    , content = ""
    , tags = ""
    , errorsVisible = False
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
            ( { model | request = InProgress }, publishArticle model.mode toCreate )

        PublishResponseReceived (Ok id) ->
            ( model, Effect.goToArticle id )

        PublishResponseReceived (Err _) ->
            ( { model | request = publishFailed }, Effect.none )

        PublishClickedWithErrors inputs ->
            ( { model | inputs = Api.Success inputs }, Effect.none )

        EditResponseReceived (Ok id) ->
            ( model, Effect.goToArticle id )

        EditResponseReceived (Err _) ->
            ( { model | request = editFailed }, Effect.none )


editFailed : Request
editFailed =
    Failed "Couldn't update article, try again?"


publishFailed : Request
publishFailed =
    Failed "Couldn't publish article, try again?"


toInputs : Article -> Inputs
toInputs article =
    { title = Article.title article
    , about = Article.about article
    , content = Article.content article
    , tags = tagsToString article
    , errorsVisible = False
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
            Api.Articles.edit EditResponseReceived id



-- View


view : User.Profile -> Context -> Model -> Element Msg
view user context model =
    Layout.authenticated user context (page model) Layout.layout


page : Model -> Element Msg
page model =
    case model.inputs of
        Api.Loading ->
            el [ moveDown Scale.small ] Loader.default

        Api.NotFound ->
            Text.text [] "No article found"

        Api.Failure ->
            Text.error [] "Error loading article"

        Api.Success inputs_ ->
            page_ model inputs_


page_ : Model -> Inputs -> Element Msg
page_ model inputs =
    column [ width fill, spacing Scale.small ]
        [ column
            [ width fill
            , spacing Scale.medium
            , paddingEach { edges | top = Scale.large }
            ]
            [ title inputs
            , about inputs
            , content inputs
            , tags inputs
            , showTags inputs.tags
            , publishButton model inputs
            ]
        , preview inputs
        ]


preview : Inputs -> Element msg
preview inputs =
    column [ spacing Scale.extraLarge, width fill ]
        [ column [ spacing Scale.medium, width fill ]
            [ Text.mobileHeadline [ Text.grey ] inputs.title
            , Text.title [ Text.grey ] inputs.about
            ]
        , Markdown.view inputs.content
        ]


publishButton : Model -> Inputs -> Element Msg
publishButton model inputs =
    column [ alignRight, spacing Scale.small ]
        [ el [ alignRight ] (publishButton_ model inputs)
        , el [ alignRight ] (errorMessage model.request)
        ]


publishButton_ : Model -> Inputs -> Element Msg
publishButton_ model inputs =
    Button.validateOnSubmit
        { label = "Publish Article"
        , validation = validation inputs
        , inputs = inputs
        , style = buttonStyle model.request
        , onSubmit = PublishClicked
        , onError = PublishClickedWithErrors
        }


buttonStyle : Request -> Button msg -> Button msg
buttonStyle request =
    case request of
        InProgress ->
            Button.conduit

        Idle ->
            identity

        Failed _ ->
            identity


errorMessage : Request -> Element msg
errorMessage request =
    case request of
        InProgress ->
            none

        Idle ->
            none

        Failed reason ->
            Text.error [] reason


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
        >> wrappedRow_ [ spacing Scale.small, width fill ]


showTag : Tag -> Element msg
showTag tag_ =
    Text.text [ Text.green, Text.description "visible-tag" ] ("#" ++ Tag.value tag_)


title : Inputs -> Element Msg
title inputs =
    title_
        |> Field.large
        |> validate inputs
        |> textInput inputs


about : Inputs -> Element Msg
about inputs =
    about_
        |> Field.small
        |> validate inputs
        |> textInput inputs


content : Inputs -> Element Msg
content inputs =
    content_
        |> Field.area
        |> validate inputs
        |> textInput inputs


tags : Inputs -> Element Msg
tags inputs =
    tags_
        |> Field.small
        |> textInput inputs


validate : Inputs -> Field.View Inputs Article.Inputs -> Field.View Inputs Article.Inputs
validate inputs =
    Field.validateWith (validation inputs) >> Field.showErrorsIf inputs.errorsVisible



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
