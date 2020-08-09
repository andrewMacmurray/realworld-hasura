module Api.Articles exposing
    ( all
    , articleSelection
    , byTag
    , deleteComment
    , edit
    , followedByAuthor
    , like
    , load
    , loadArticle
    , loadFeed
    , newestFirst
    , postComment
    , publish
    , unlike
    , updateComment
    )

import Api
import Api.Argument as Argument exposing (..)
import Api.Date as Date
import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Article.Comment as Comment exposing (Comment, Comment_)
import Effect exposing (Effect)
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.Enum.Order_by exposing (Order_by(..))
import Hasura.Enum.Tags_select_column as Tags_select_column
import Hasura.InputObject as Input
import Hasura.Mutation as Mutation
import Hasura.Object exposing (Articles)
import Hasura.Object.Articles as Articles exposing (CommentsOptionalArguments)
import Hasura.Object.Comments as Comments
import Hasura.Object.Likes as Likes
import Hasura.Object.Likes_aggregate as LikesAggregate
import Hasura.Object.Likes_aggregate_fields as LikesAggregateFields
import Hasura.Object.Tags as Tags
import Hasura.Object.UnlikeResponse as UnlikeResponse
import Hasura.Object.Users as Users
import Hasura.Query as Query
import Tag exposing (Tag)
import User
import Utils.SelectionSet as SelectionSet



-- Article


loadArticle : Article.Id -> (Api.Response (Maybe Article) -> msg) -> Effect msg
loadArticle id msg =
    Query.article { id = id } articleSelection
        |> Api.query msg
        |> Effect.loadArticle



--  Articles


load : SelectionSet (List Article) RootQuery -> (Api.Response (List Article) -> msg) -> Effect msg
load selection msg =
    selection
        |> Api.query msg
        |> Effect.loadArticles



-- Global Feed


loadFeed : SelectionSet (List Article) RootQuery -> (Api.Response Article.Feed -> msg) -> Effect msg
loadFeed articlesSelection_ msg =
    SelectionSet.succeed Article.Feed
        |> with articlesSelection_
        |> with popularTagsSelection
        |> Api.query msg
        |> Effect.loadFeed



-- By Tag


byTag : Tag -> SelectionSet (List Article) RootQuery
byTag tag =
    Query.articles (newestFirst >> containsTag tag) articleSelection


containsTag : Tag -> Query.ArticlesOptionalArguments -> Query.ArticlesOptionalArguments
containsTag tag_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (tags Input.buildTags_bool_exp)
        (tag Input.buildString_comparison_exp)
        (eq_ (Tag.value tag_))



-- By Author


followedByAuthor : User.Profile -> SelectionSet (List Article) RootQuery
followedByAuthor profile =
    Query.articles (newestFirst >> followedBy profile) articleSelection


followedBy : User.Profile -> Query.ArticlesOptionalArguments -> Query.ArticlesOptionalArguments
followedBy profile =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (author Input.buildUsers_bool_exp)
        (id Input.buildInt_comparison_exp)
        (in_ (User.id profile :: User.following profile))



-- Popular Tags


popularTagsSelection : SelectionSet (List Tag.Popular) RootQuery
popularTagsSelection =
    Query.tags distinctAndLimit popularTagSelection
        |> SelectionSet.map (List.sortBy .count >> List.reverse)


distinctAndLimit : Query.TagsOptionalArguments -> Query.TagsOptionalArguments
distinctAndLimit args =
    { args | distinct_on = Present [ Tags_select_column.Tag ], limit = Present 20 }


popularTagSelection : SelectionSet Tag.Popular Hasura.Object.Tags
popularTagSelection =
    SelectionSet.succeed Tag.Popular
        |> with (SelectionSet.map Tag.one Tags.tag)
        |> with (SelectionSet.map (Maybe.withDefault 0) Tags.count)



-- Articles


all : SelectionSet (List Article) RootQuery
all =
    Query.articles newestFirst articleSelection


articleSelection : SelectionSet Article Hasura.Object.Articles
articleSelection =
    SelectionSet.map Article.build
        (SelectionSet.succeed Article.Details
            |> with Articles.id
            |> with Articles.title
            |> with Articles.about
            |> with Articles.content
            |> with (Articles.author authorSelection)
            |> with (Date.fromScalar Articles.created_at)
            |> with (Articles.tags identity tagSelection)
            |> with (Articles.likes_aggregate identity likesCountSelection)
            |> with (Articles.likes identity likedBySelection)
            |> with (Articles.comments newestCommentsFirst commentSelection)
        )


newestCommentsFirst : CommentsOptionalArguments -> CommentsOptionalArguments
newestCommentsFirst =
    Argument.combine2
        (order_by Input.buildComments_order_by)
        (created_at Desc)


commentSelection : SelectionSet Comment Hasura.Object.Comments
commentSelection =
    SelectionSet.map Comment.build
        (SelectionSet.succeed Comment_
            |> with Comments.id
            |> with Comments.comment
            |> with (Date.fromScalar Comments.created_at)
            |> with (Comments.user authorSelection)
        )


authorSelection : SelectionSet Author Hasura.Object.Users
authorSelection =
    SelectionSet.succeed Author.build
        |> with Users.id
        |> with Users.username
        |> with Users.profile_image


likedBySelection : SelectionSet Author Hasura.Object.Likes
likedBySelection =
    Likes.user
        (SelectionSet.succeed Author.build
            |> with Users.id
            |> with Users.username
            |> with Users.profile_image
        )


likesCountSelection : SelectionSet Int Hasura.Object.Likes_aggregate
likesCountSelection =
    LikesAggregate.aggregate (LikesAggregateFields.count identity)
        |> SelectionSet.map (Maybe.andThen identity >> Maybe.withDefault 0)


tagSelection : SelectionSet Tag.Tag Hasura.Object.Tags
tagSelection =
    SelectionSet.map Tag.one Tags.tag


newestFirst : Query.ArticlesOptionalArguments -> Query.ArticlesOptionalArguments
newestFirst =
    Argument.combine2
        (order_by Input.buildArticles_order_by)
        (created_at Desc)



-- Publish


publish : (Api.Response () -> msg) -> Article.ToCreate -> Effect msg
publish msg article_ =
    Mutation.publish_article identity { object = toPublishArgs article_ } SelectionSet.empty
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.publishArticle


toPublishArgs : Article.ToCreate -> Input.Articles_insert_input
toPublishArgs article_ =
    Input.buildArticles_insert_input
        (\args ->
            { args
                | title = Argument.fromNonEmpty article_.title
                , about = Argument.fromNonEmpty article_.about
                , content = Argument.fromNonEmpty article_.content
                , tags = Present (toTagsArgs article_.tags)
            }
        )


toTagsArgs : List Tag -> Input.Tags_arr_rel_insert_input
toTagsArgs tags =
    Input.buildTags_arr_rel_insert_input { data = List.map toTagArg tags }


toTagArg : Tag -> Input.Tags_insert_input
toTagArg tag_ =
    Input.buildTags_insert_input (\args -> { args | tag = Present (Tag.value tag_) })



-- Edit


edit : (Api.Response () -> msg) -> Article.Id -> Article.ToCreate -> Effect msg
edit msg id_ edits =
    SelectionSet.succeed (\_ _ _ -> ())
        |> with (editArticle id_ edits)
        |> with (insertTags id_ edits)
        |> with (deleteTags id_)
        |> Api.mutation msg
        |> Effect.editArticle


insertTags : Article.Id -> Article.ToCreate -> SelectionSet () RootMutation
insertTags id_ edits =
    SelectionSet.empty
        |> Mutation.insert_tags { objects = List.map (toTagsArgs_ id_) edits.tags }
        |> SelectionSet.failOnNothing


toTagsArgs_ : Article.Id -> Tag -> Input.Tags_insert_input
toTagsArgs_ id_ tag_ =
    Input.buildTags_insert_input
        (\args ->
            { args
                | article_id = Present id_
                , tag = Present (Tag.value tag_)
            }
        )


deleteTags : Int -> SelectionSet () RootMutation
deleteTags id =
    SelectionSet.empty
        |> Mutation.delete_tags { where_ = Input.buildTags_bool_exp (tagIsForArticle id) }
        |> SelectionSet.failOnNothing


tagIsForArticle : Article.Id -> Input.Tags_bool_expOptionalFields -> Input.Tags_bool_expOptionalFields
tagIsForArticle id_ =
    Argument.combine3
        (article Input.buildArticles_bool_exp)
        (id Input.buildInt_comparison_exp)
        (eq_ id_)


editArticle : Int -> Article.ToCreate -> SelectionSet () RootMutation
editArticle id edits =
    SelectionSet.empty
        |> Mutation.edit_article (editArticleArgs edits) { pk_columns = { id = id } }
        |> SelectionSet.failOnNothing


editArticleArgs :
    Article.ToCreate
    -> Mutation.EditArticleOptionalArguments
    -> Mutation.EditArticleOptionalArguments
editArticleArgs edits args =
    { args
        | set_ =
            Present
                { about = Argument.fromNonEmpty edits.about
                , title = Argument.fromNonEmpty edits.title
                , content = Argument.fromNonEmpty edits.content
                }
    }



-- Like


like : Article -> (Api.Response Article -> msg) -> Effect msg
like article msg =
    Mutation.like_article { object = likeArticleArgs article } (Likes.article articleSelection)
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.likeArticle


likeArticleArgs : Article -> Input.Likes_insert_input
likeArticleArgs article =
    Input.buildLikes_insert_input (\args -> { args | article_id = Present (Article.id article) })



-- Unlike


unlike : Article -> (Api.Response Article -> msg) -> Effect msg
unlike article msg =
    UnlikeResponse.article articleSelection
        |> Mutation.unlike_article { article_id = Article.id article }
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.unlikeArticle



-- Post Comment


postComment : (Api.Response Article -> msg) -> Article -> String -> Effect msg
postComment msg article comment =
    mutateCommentsSelection
        |> Mutation.post_comment identity { object = postCommentArgs article comment }
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.postComment


mutateCommentsSelection : SelectionSet Article Hasura.Object.Comments
mutateCommentsSelection =
    Comments.article articleSelection


postCommentArgs : Article -> String -> Input.Comments_insert_input
postCommentArgs article comment =
    Input.buildComments_insert_input
        (\args ->
            { args
                | article_id = Present (Article.id article)
                , comment = Present comment
            }
        )



-- Delete Comment


deleteComment : (Api.Response Article -> msg) -> Comment -> Effect msg
deleteComment msg comment =
    Mutation.delete_comment { id = Comment.id comment } mutateCommentsSelection
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.deleteComment



-- Update Comment


updateComment : (Api.Response Article -> msg) -> Comment -> Effect msg
updateComment msg comment =
    mutateCommentsSelection
        |> Mutation.update_comment (updateCommentArgs comment) (updateCommentId comment)
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.updateComment


updateCommentId : Comment -> Mutation.UpdateCommentRequiredArguments
updateCommentId comment =
    { pk_columns = { id = Comment.id comment } }


updateCommentArgs : Comment -> Mutation.UpdateCommentOptionalArguments -> Mutation.UpdateCommentOptionalArguments
updateCommentArgs comment =
    Argument.combine2
        (set_ Input.buildComments_set_input)
        (comment_ (Comment.value comment))
