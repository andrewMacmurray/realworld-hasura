module Page.Article exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Article exposing (Article)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Layout as Layout
import Element.Scale as Scale
import Element.Text as Text
import User exposing (User(..))



-- Model


type alias Model =
    { article : LoadStatus Article
    }


type Msg
    = ArticleReceived (Api.Response (Maybe Article))


type LoadStatus a
    = Loading
    | Loaded a
    | NotFound
    | FailedToLoad



-- Init


init : Article.Id -> ( Model, Effect Msg )
init id =
    ( initialModel, loadArticle id )


loadArticle : Article.Id -> Effect Msg
loadArticle id =
    Api.Articles.loadArticle id ArticleReceived


initialModel : Model
initialModel =
    { article = Loading
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ArticleReceived (Ok (Just article)) ->
            ( { model | article = Loaded article }, Effect.none )

        ArticleReceived (Ok Nothing) ->
            ( { model | article = NotFound }, Effect.none )

        ArticleReceived (Err _) ->
            ( { model | article = FailedToLoad }, Effect.none )



-- View


view : User -> Model -> Element Msg
view user model =
    case user of
        Guest ->
            Layout.guest [ showArticle model.article ]

        LoggedIn profile ->
            Layout.loggedIn profile [ showArticle model.article ]


showArticle : LoadStatus Article -> Element msg
showArticle article_ =
    case article_ of
        Loading ->
            Text.text [] "Loading..."

        Loaded a ->
            showArticle_ a

        NotFound ->
            Text.text [ Anchor.description "not-found-message" ] "Article Not Found"

        FailedToLoad ->
            Text.text [ Anchor.description "error-message" ] "There was an error loading the article"


showArticle_ : Article -> Element msg
showArticle_ a =
    column [ spacing Scale.large ]
        [ Text.title [ Anchor.description "article-title" ] (Article.title a)
        , Text.date [] (Article.createdAt a)
        , Text.subtitle [] (Article.about a)
        , Text.text [] (Article.content a)
        ]
