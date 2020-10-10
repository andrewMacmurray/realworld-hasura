module Api.Authors exposing
    ( FeedSelection
    , authoredArticles
    , likedArticles
    , loadFeed
    )

import Api
import Api.Argument as Argument exposing (..)
import Api.Articles as Articles
import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Article.Feed as Feed exposing (Feed)
import Effect exposing (Effect)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.InputObject as Input
import Hasura.Object exposing (Users)
import Hasura.Object.Users as Users
import Hasura.Query exposing (ArticlesOptionalArguments)


type alias FeedSelection =
    Author.Id -> SelectionSet Feed RootQuery



-- load


loadFeed : FeedSelection -> Author.Id -> (Api.Response (Maybe Feed.ForAuthor) -> msg) -> Effect msg
loadFeed articles id_ msg =
    authorFeedSelection id_ articles
        |> Api.query msg
        |> Effect.loadAuthorFeed


authorFeedSelection : Author.Id -> FeedSelection -> SelectionSet (Maybe Feed.ForAuthor) RootQuery
authorFeedSelection id_ selection =
    SelectionSet.succeed Feed.forAuthor
        |> with (authorById id_)
        |> with (selection id_)


authoredArticles : FeedSelection
authoredArticles id_ =
    SelectionSet.succeed Feed
        |> with (authoredArticles_ id_)
        |> with (SelectionSet.succeed 0)


authoredArticles_ : Author.Id -> SelectionSet (List Article) RootQuery
authoredArticles_ id_ =
    Hasura.Query.articles
        (Articles.newestFirst >> authoredBy id_)
        Articles.articleSelection


likedArticles : FeedSelection
likedArticles id_ =
    SelectionSet.succeed Feed
        |> with (likedArticles_ id_)
        |> with (SelectionSet.succeed 0)


likedArticles_ : Author.Id -> SelectionSet (List Article) RootQuery
likedArticles_ id_ =
    Hasura.Query.articles
        (Articles.newestFirst >> likedBy id_)
        Articles.articleSelection


authoredBy : Author.Id -> ArticlesOptionalArguments -> ArticlesOptionalArguments
authoredBy id_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (author Input.buildUsers_bool_exp)
        (id Input.buildInt_comparison_exp)
        (eq_ id_)


likedBy : Author.Id -> ArticlesOptionalArguments -> ArticlesOptionalArguments
likedBy id_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (likes Input.buildLikes_bool_exp)
        (user_id Input.buildInt_comparison_exp)
        (eq_ id_)


authorById : Author.Id -> SelectionSet (Maybe Author) RootQuery
authorById id_ =
    Hasura.Query.user { id = id_ } authorSelection


authorSelection : SelectionSet Author Users
authorSelection =
    SelectionSet.succeed Author.build
        |> with Users.id
        |> with Users.username
        |> with Users.profile_image
