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
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Button as Button exposing (Button)
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Layout as Layout exposing (Layout)
import Element.Layout.Block as Block
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Form.Field as Field
import Form.View.Field as Field
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import User.Element as Element
import Utils.String as String



-- Model


type alias Model =
    { article : LoadStatus Article
    , newComment : String
    , commentEdit : CommentEdit
    }


type Msg
    = ArticleReceived (Api.Response (Maybe Article))
    | FollowMsg Follow.Msg
    | CommentTyped String
    | PostCommentClicked Article
    | PostCommentResponseReceived (Api.Response Article)
    | CommentEditUnfocused
    | DeleteCommentClicked Comment
    | DeleteCommentResponseReceived (Api.Response Article)
    | DeleteAreYouSureClicked Comment
    | EditCommentClicked Comment
    | CommentEdited Comment
    | SubmitEditClicked Comment
    | UpdateCommentResponseReceived (Api.Response Article)


type LoadStatus a
    = Loading
    | Loaded a
    | NotFound
    | FailedToLoad


type CommentEdit
    = None
    | Editing Comment
    | ConfirmDelete Comment
    | Updating Comment



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
    , newComment = ""
    , commentEdit = None
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

        FollowMsg msg_ ->
            ( model, handleFollowEffect msg_ )

        CommentTyped comment ->
            ( { model | newComment = comment, commentEdit = None }, Effect.none )

        PostCommentClicked article ->
            ( model, postComment article model.newComment )

        PostCommentResponseReceived (Ok article) ->
            ( resetComments { model | article = Loaded article }, Effect.none )

        PostCommentResponseReceived (Err _) ->
            ( model, Effect.none )

        DeleteCommentClicked comment ->
            ( { model | commentEdit = ConfirmDelete comment }, Effect.none )

        DeleteAreYouSureClicked comment ->
            ( { model | commentEdit = Updating comment }, deleteComment comment )

        DeleteCommentResponseReceived (Ok article) ->
            ( resetComments { model | article = Loaded article }, Effect.none )

        DeleteCommentResponseReceived (Err _) ->
            ( resetComments model, Effect.none )

        EditCommentClicked comment ->
            ( { model | commentEdit = Editing comment }, Effect.none )

        CommentEdited comment ->
            ( { model | commentEdit = Editing comment }, Effect.none )

        SubmitEditClicked comment ->
            ( { model | commentEdit = Updating comment }, updateComment comment )

        UpdateCommentResponseReceived (Ok article) ->
            ( resetComments { model | article = Loaded article }, Effect.none )

        UpdateCommentResponseReceived (Err _) ->
            ( resetComments model, Effect.none )

        CommentEditUnfocused ->
            ( { model | commentEdit = None }, Effect.none )


resetComments : Model -> Model
resetComments model =
    { model | newComment = "", commentEdit = None }


handleFollowEffect : Follow.Msg -> Effect Msg
handleFollowEffect =
    Follow.effect >> Effect.map FollowMsg


postComment : Article -> String -> Effect Msg
postComment =
    Api.Articles.postComment PostCommentResponseReceived


deleteComment : Comment -> Effect Msg
deleteComment =
    Api.Articles.deleteComment DeleteCommentResponseReceived


updateComment : Comment -> Effect Msg
updateComment =
    Api.Articles.updateComment UpdateCommentResponseReceived



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner user model
        |> Layout.toPage (articleBody user model)


withBanner : User -> Model -> Layout Msg -> Layout Msg
withBanner user model layout =
    case model.article of
        Loaded article ->
            bannerConfig (loadedBanner user article) layout

        _ ->
            bannerConfig none layout


bannerConfig : Element msg -> Layout msg -> Layout msg
bannerConfig =
    Layout.withBanner [ Background.color Palette.black ]


loadedBanner : User -> Article -> Element Msg
loadedBanner user article =
    row [ width fill ]
        [ column [ spacing Scale.large, width fill ]
            [ headline article
            , row [ spacing Scale.medium ]
                [ author article
                , followButton user article
                ]
            ]
        , el [ alignRight, alignBottom ] (tags article)
        ]


followButton : User -> Article -> Element Msg
followButton user article =
    Follow.button
        { user = user
        , author = Article.author article
        , msg = FollowMsg
        }


tags : Article -> Element msg
tags article =
    row [ spacing Scale.small ] (List.map viewTag <| Article.tags article)


viewTag : Tag -> Element msg
viewTag tag =
    Route.el (Route.tagFeed tag) (Text.link [] ("#" ++ Tag.value tag))


headline : Article -> Element msg
headline article =
    paragraph []
        [ Text.headline
            [ Text.white
            , Text.description "article-title"
            ]
            (Article.title article)
        ]


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
        Loading ->
            Text.text [] "Loading..."

        Loaded article ->
            showArticleBody user model article

        NotFound ->
            Text.text [ Text.description "not-found-message" ] "Article Not Found"

        FailedToLoad ->
            Text.text [ Text.description "error-message" ] "There was an error loading the article"


showArticleBody : User -> Model -> Article -> Element Msg
showArticleBody user model article =
    column [ spacing Scale.large, width fill, height fill ]
        [ paragraph [] [ Text.title [] (Article.about article) ]
        , paragraph [ Font.color Palette.black ] [ Text.text [] (Article.content article) ]
        , el [ width fill, paddingEach { edges | top = Scale.extraLarge } ]
            (comments user model article)
        ]



-- Comments


comments : User -> Model -> Article -> Element Msg
comments user model article =
    Block.halfWidth
        (column
            [ spacing Scale.large
            , width fill
            , height fill
            , Anchor.description "comments"
            ]
            [ Text.title [ Text.green ] (commentsTitle (Article.comments article))
            , newComment article model user
            , column [ spacing Scale.large, width fill ]
                (List.map (showComment model.commentEdit user) (Article.comments article))
            ]
        )


newComment : Article -> Model -> User -> Element Msg
newComment article model =
    Element.showIfLoggedIn (newComment_ article model)


newComment_ : Article -> Model -> Element Msg
newComment_ article model =
    row
        [ width fill
        , spacing Scale.medium
        , height fill
        , onClick CommentEditUnfocused
        , onRight (el [ alignBottom, moveRight Scale.small ] (postCommentButton article))
        ]
        [ commentInput model.newComment
        ]


postCommentButton : Article -> Element Msg
postCommentButton article =
    Button.button (PostCommentClicked article) "Post"
        |> Button.description "post-new-comment"
        |> Button.post
        |> Button.toElement


commentInput : String -> Element Msg
commentInput =
    Field.field
        { label = "Post a new comment"
        , value = identity
        , update = always identity
        }
        |> Field.borderless
        |> Field.toElement CommentTyped


commentsTitle : List Comment -> String
commentsTitle comments_ =
    String.pluralize "Comment" (List.length comments_)


showComment : CommentEdit -> User -> Comment -> Element Msg
showComment edit user comment =
    row
        [ spacing Scale.extraLarge
        , onRight (commentActions edit comment user)
        , Anchor.description "comment"
        , width fill
        ]
        [ el [ alignTop ] (commentAuthor comment)
        , toCommentText user edit comment
        ]


toCommentText : User -> CommentEdit -> Comment -> Element Msg
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
        None ->
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


commentActions : CommentEdit -> Comment -> User -> Element Msg
commentActions edit comment user =
    Element.showIfMe (editComment edit comment) user (Comment.by comment)


editComment : CommentEdit -> Comment -> Element Msg
editComment edit comment =
    el
        [ moveRight Scale.small
        , Anchor.description "comment-actions"
        ]
        (editComment_ edit comment)


editComment_ : CommentEdit -> Comment -> Element Msg
editComment_ edit comment =
    let
        optionsButton =
            Button.button (EditCommentClicked comment) "Edit"
                |> Button.ellipsis
                |> Button.toElement
    in
    case edit of
        None ->
            optionsButton

        Updating _ ->
            Text.text [] "Updating"

        ConfirmDelete comment_ ->
            if Comment.equals comment comment_ then
                row [ spacing Scale.extraSmall ]
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
                row [ spacing Scale.extraSmall ]
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
