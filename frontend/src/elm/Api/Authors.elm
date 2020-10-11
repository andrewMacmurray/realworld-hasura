module Api.Authors exposing
    ( FeedSelection
    , authoredArticles
    , likedArticles
    , loadFeed
    )

import Api
import Api.Argument as Argument exposing (..)
import Api.Articles as Articles
import Article.Author as Author exposing (Author)
import Article.Feed as Feed exposing (Feed)
import Article.Page as Page
import Effect exposing (Effect)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.InputObject as Input
import Hasura.Object exposing (Users)
import Hasura.Object.Users as Users
import Hasura.Query exposing (ArticlesOptionalArguments)


type alias FeedSelection =
    Author.Id -> Page.Number -> SelectionSet Feed RootQuery


authoredArticles : FeedSelection
authoredArticles id_ page_ =
    Articles.feedSelection page_ (Articles.newestFirst >> authoredBy id_)


likedArticles : FeedSelection
likedArticles id_ page_ =
    Articles.feedSelection page_ (Articles.newestFirst >> likedBy id_)



-- load


loadFeed : FeedSelection -> Author.Id -> Page.Number -> (Api.Response (Maybe Feed.ForAuthor) -> msg) -> Effect msg
loadFeed articles id_ page_ msg =
    authorFeedSelection id_ page_ articles
        |> Api.query msg
        |> Effect.loadAuthorFeed


authorFeedSelection : Author.Id -> Page.Number -> FeedSelection -> SelectionSet (Maybe Feed.ForAuthor) RootQuery
authorFeedSelection id_ page_ selection =
    SelectionSet.succeed Feed.forAuthor
        |> with (authorById id_)
        |> with (selection id_ page_)


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
