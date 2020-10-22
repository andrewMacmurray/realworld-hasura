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
import Article.Author as Author exposing (Author)
import Article.Author.Follow as Follow
import Article.Comment as Comment exposing (Comment)
import Context exposing (Context)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Button as Button exposing (Button)
import Element.Events exposing (onClick)
import Element.Layout as Layout exposing (Layout)
import Element.Layout.Block as Block
import Element.Loader.Conduit as Loader
import Element.Markdown as Markdown
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Form.Button as Button
import Form.Field as Field
import Form.Validation as Validation exposing (Validation)
import Form.View.Field as Field
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import User.Element as Element
import Utils.Element as Element
import Utils.String as String



-- Model


type alias Model =
    { article : Api.Data Article
    , newComment : String
    , commentAction : CommentAction
    , articleAction : ArticleAction
    }


type Msg
    = ArticleReceived (Api.Response (Maybe Article))
    | FollowMsg Follow.Msg
    | CommentTyped String
    | PostCommentClicked Article String.NonEmpty
    | PostCommentResponseReceived (Api.Response Article)
    | CommentEditUnfocused
    | DeleteCommentClicked Comment
    | DeleteCommentResponseReceived (Api.Response Article)
    | DeleteAreYouSureClicked Comment
    | EditCommentClicked Comment
    | CommentEdited Comment
    | SubmitEditClicked Comment
    | UpdateCommentResponseReceived (Api.Response Article)
    | DeleteArticleClicked
    | ConfirmDeleteArticleClicked Article
    | DeleteArticleResponseReceived (Api.Response ())


type CommentAction
    = NoCommentAction
    | Editing Comment
    | ConfirmDelete Comment
    | Updating Comment


type ArticleAction
    = NoArticleAction
    | ConfirmDeleteArticle
    | ArticleDeleting



-- Init


init : Article.Id -> ( Model, Effect Msg )
init id =
    ( initialModel, loadArticle id )


loadArticle : Article.Id -> Effect Msg
loadArticle id =
    Api.Articles.loadArticle id ArticleReceived


initialModel : Model
initialModel =
    { article = Api.Loading
    , newComment = ""
    , commentAction = NoCommentAction
    , articleAction = NoArticleAction
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ArticleReceived response ->
            ( { model | article = Api.fromNullableResponse response }, Effect.none )

        FollowMsg msg_ ->
            ( model, handleFollowEffect msg_ )

        CommentTyped comment ->
            ( { model | newComment = comment, commentAction = NoCommentAction }, Effect.none )

        PostCommentClicked article comment ->
            ( model, postComment article comment )

        PostCommentResponseReceived response ->
            ( resetComments { model | article = Api.fromResponse response }, Effect.none )

        DeleteCommentClicked comment ->
            ( { model | commentAction = ConfirmDelete comment }, Effect.none )

        DeleteAreYouSureClicked comment ->
            ( { model | commentAction = Updating comment }, deleteComment comment )

        DeleteCommentResponseReceived response ->
            ( resetComments { model | article = Api.fromResponse response }, Effect.none )

        EditCommentClicked comment ->
            ( { model | commentAction = Editing comment }, Effect.none )

        CommentEdited comment ->
            ( { model | commentAction = Editing comment }, Effect.none )

        SubmitEditClicked comment ->
            ( { model | commentAction = Updating comment }, updateComment comment )

        UpdateCommentResponseReceived response ->
            ( resetComments { model | article = Api.fromResponse response }, Effect.none )

        CommentEditUnfocused ->
            ( resetActions model, Effect.none )

        DeleteArticleClicked ->
            ( { model | articleAction = ConfirmDeleteArticle }, Effect.none )

        ConfirmDeleteArticleClicked article ->
            ( { model | articleAction = ArticleDeleting }, deleteArticle article )

        DeleteArticleResponseReceived (Ok _) ->
            ( model, Effect.redirectHome )

        DeleteArticleResponseReceived (Err _) ->
            ( model, Effect.none )


resetComments : Model -> Model
resetComments model =
    resetActions { model | newComment = "" }


resetActions : Model -> Model
resetActions model =
    { model | commentAction = NoCommentAction, articleAction = NoArticleAction }


handleFollowEffect : Follow.Msg -> Effect Msg
handleFollowEffect =
    Follow.effect >> Effect.map FollowMsg


postComment : Article -> String.NonEmpty -> Effect Msg
postComment =
    Api.Articles.postComment PostCommentResponseReceived


deleteComment : Comment -> Effect Msg
deleteComment =
    Api.Articles.deleteComment DeleteCommentResponseReceived


updateComment : Comment -> Effect Msg
updateComment =
    Api.Articles.updateComment UpdateCommentResponseReceived


deleteArticle : Article -> Effect Msg
deleteArticle =
    Api.Articles.delete DeleteArticleResponseReceived



-- View


view : Context -> Model -> Element Msg
view context model =
    Layout.layout
        |> withBanner context.user model
        |> Layout.toPage context (articleBody context.user model)


withBanner : User -> Model -> Layout Msg -> Layout Msg
withBanner user model layout =
    case model.article of
        Api.Success article ->
            bannerConfig (loadedBanner model user article) layout

        _ ->
            bannerConfig none layout


bannerConfig : Element msg -> Layout msg -> Layout msg
bannerConfig =
    Layout.withBanner [ Background.color Palette.black ]


loadedBanner : Model -> User -> Article -> Element Msg
loadedBanner model user article =
    row [ width fill ]
        [ column [ spacing Scale.large, width fill ]
            [ headline article
            , row [ spacing Scale.medium ]
                [ author article
                , followButton user article
                ]
            , actionButtons model user article
            ]
        , Element.desktopOnly el [ paddingXY 0 0, alignRight, alignBottom ] (tags Text.white article)
        ]


actionButtons : Model -> User -> Article -> Element Msg
actionButtons model user article =
    Element.showIfMe
        (row []
            [ editArticleButton article
            , deleteArticleButton model article
            ]
        )
        user
        (Article.author article)


deleteArticleButton : Model -> Article -> Element Msg
deleteArticleButton model article =
    let
        delete =
            Button.delete
                >> Button.light
                >> Button.description "delete-article"
                >> Button.toElement
    in
    case model.articleAction of
        NoArticleAction ->
            delete (Button.button DeleteArticleClicked "Delete Article")

        ConfirmDeleteArticle ->
            delete (Button.button (ConfirmDeleteArticleClicked article) "Are you sure?")

        ArticleDeleting ->
            delete (Button.decorative "Deleting...")


editArticleButton : Article -> Element msg
editArticleButton article =
    Route.button (Route.editArticle article) "Edit Article"
        |> Button.edit
        |> Button.light
        |> Button.description "edit-article"
        |> Button.toElement


followButton : User -> Article -> Element Msg
followButton user article =
    Follow.button
        { user = user
        , author = Article.author article
        , msg = FollowMsg
        }


tags : Text.Option -> Article -> Element msg
tags textOption article =
    row [ spacing Scale.small ] (List.map (viewTag textOption) <| Article.tags article)


viewTag : Text.Option -> Tag -> Element msg
viewTag textOption tag =
    Route.el (Route.tagFeed tag) (Text.link [ textOption ] ("#" ++ Tag.value tag))


headline : Article -> Element msg
headline article =
    paragraph [] [ headline_ article ]


headline_ : Article -> Element msg
headline_ article =
    Text.mobileHeadline
        [ Text.white
        , Text.description "article-title"
        ]
        (Article.title article)


author : Article -> Element msg
author article =
    authorLink (Article.author article)
        (row [ spacing Scale.small ]
            [ Avatar.medium (Article.profileImage article)
            , column [ spacing Scale.extraSmall ]
                [ Text.link [ Text.white ] (Article.authorUsername article)
                , Text.date [] (Article.createdAt article)
                ]
            ]
        )


authorLink : Author -> Element msg -> Element msg
authorLink =
    Route.author >> Route.el


articleBody : User -> Model -> Element Msg
articleBody user model =
    case model.article of
        Api.Loading ->
            el [ moveLeft Scale.medium ] Loader.default

        Api.Success article ->
            showArticleBody user model article

        Api.NotFound ->
            Text.text [ Text.description "not-found-message" ] "Article Not Found"

        Api.Failure ->
            Text.text [ Text.description "error-message" ] "There was an error loading the article"


showArticleBody : User -> Model -> Article -> Element Msg
showArticleBody user model article =
    column [ spacing Scale.large, width fill, height fill, paddingEach { edges | bottom = Scale.extraLarge } ]
        [ Element.mobileOnly el [] (tags Text.grey article)
        , paragraph [] [ Text.title [ Text.green ] (Article.about article) ]
        , content article
        , comments user model article
        ]


content : Article -> Element msg
content article =
    el [ paddingEach { edges | top = Scale.large }, width fill ] (Markdown.view (Article.content article))



-- Comments


comments : User -> Model -> Article -> Element Msg
comments user model article =
    el [ width fill, paddingEach { edges | top = Scale.extraLarge } ] (comments_ user model article)


comments_ : User -> Model -> Article -> Element Msg
comments_ user model article =
    Block.halfWidthPlus 100
        (column
            [ spacing Scale.large
            , width fill
            , height fill
            , Anchor.description "comments"
            ]
            [ Text.subtitle [ Text.green, Text.regular ] (commentsTitle (Article.comments article))
            , newComment article model user
            , column [ spacing Scale.large, width fill ] (showComments user model article)
            ]
        )


showComments : User -> Model -> Article -> List (Element Msg)
showComments user model article =
    List.map (showComment model.commentAction user) (Article.comments article)


newComment : Article -> Model -> User -> Element Msg
newComment article model =
    Element.showIfLoggedIn (newComment_ article model)


newComment_ : Article -> Model -> Element Msg
newComment_ article model =
    row
        [ width fill
        , spacing Scale.extraSmall
        , height fill
        , onClick CommentEditUnfocused
        ]
        [ commentInput model.newComment
        , postCommentButton model.newComment article
        ]


postCommentButton : String -> Article -> Element Msg
postCommentButton comment article =
    Button.validateOnInput
        { label = "Post"
        , style = Button.description "post-new-comment" >> Button.post
        , validation = nonEmptyComment
        , onSubmit = PostCommentClicked article
        , inputs = comment
        }


commentInput : String -> Element Msg
commentInput =
    commentField
        |> Field.borderless
        |> Field.validateWith nonEmptyComment
        |> Field.toElement CommentTyped


nonEmptyComment : Validation String String.NonEmpty
nonEmptyComment =
    Validation.build identity |> Validation.nonEmpty commentField


commentField : Field.Field String
commentField =
    Field.identity "Post a new comment"


commentsTitle : List Comment -> String
commentsTitle =
    String.pluralize "comment" << List.length


showComment : CommentAction -> User -> Comment -> Element Msg
showComment edit user comment =
    row
        [ width fill
        , spacing Scale.extraSmall
        , Anchor.description "comment"
        ]
        [ row
            [ width fill
            , spacing Scale.large
            ]
            [ el [ alignTop ] (commentAuthor comment)
            , toCommentText user edit comment
            ]
        , commentActions edit comment user
        ]


toCommentText : User -> CommentAction -> Comment -> Element Msg
toCommentText user edit comment =
    let
        value =
            Comment.value comment

        commentText_ =
            if Comment.isBy user comment then
                paragraph [ onClick (EditCommentClicked comment) ] [ Text.text [] value ]

            else
                paragraph [] [ Text.text [] value ]
    in
    case edit of
        NoCommentAction ->
            commentText_

        Editing comment_ ->
            if Comment.equals comment comment_ then
                editCommentField comment_

            else
                commentText_

        ConfirmDelete comment_ ->
            if Comment.equals comment comment_ then
                editCommentField comment_

            else
                commentText_

        Updating _ ->
            paragraph [] [ Text.text [] value ]


editCommentField : Comment -> Element Msg
editCommentField =
    Field.field
        { label = "Edit comment"
        , value = Comment.value
        , update = Comment.update
        }
        |> Field.borderless
        |> Field.toElement CommentEdited


commentActions : CommentAction -> Comment -> User -> Element Msg
commentActions edit comment user =
    Element.showIfMe (editComment edit comment) user (Comment.by comment)


editComment : CommentAction -> Comment -> Element Msg
editComment edit comment =
    el [ Anchor.description "comment-actions" ]
        (editComment_ edit comment)


editComment_ : CommentAction -> Comment -> Element Msg
editComment_ edit comment =
    let
        optionsButton =
            Button.button (EditCommentClicked comment) "Edit"
                |> Button.ellipsis
                |> Button.toElement
    in
    case edit of
        NoCommentAction ->
            optionsButton

        Updating _ ->
            Text.text [] "Updating"

        ConfirmDelete comment_ ->
            if Comment.equals comment comment_ then
                row []
                    [ Button.button (SubmitEditClicked comment_) "Update"
                        |> Button.edit
                        |> Button.noText
                        |> Button.toElement
                    , Button.button (DeleteAreYouSureClicked comment_) "Are you Sure?"
                        |> Button.delete
                        |> Button.toElement
                    ]

            else
                optionsButton

        Editing comment_ ->
            if Comment.equals comment comment_ then
                row []
                    [ Button.button (SubmitEditClicked comment_) "Update"
                        |> Button.edit
                        |> Button.noText
                        |> Button.toElement
                    , Button.button (DeleteCommentClicked comment_) "Delete"
                        |> Button.delete
                        |> Button.noText
                        |> Button.toElement
                    ]

            else
                optionsButton


commentAuthor : Comment -> Element msg
commentAuthor comment =
    let
        author_ =
            Comment.by comment
    in
    authorLink author_
        (row [ spacing Scale.small ]
            [ Avatar.medium (Author.profileImage author_)
            , column [ spacing Scale.extraSmall ]
                [ Text.text [ Text.black ] (Author.username author_)
                , Text.date [ Text.black ] (Comment.date comment)
                ]
            ]
        )
