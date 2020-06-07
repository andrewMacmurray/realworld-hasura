module Api.Authors exposing (feed)

import Api
import Api.Argument as Argument exposing (..)
import Api.Articles as Articles
import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Article.Author.Feed as Feed exposing (Feed)
import Effect exposing (Effect)
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.InputObject as Input
import Hasura.Object exposing (Users)
import Hasura.Object.Users as Users
import Hasura.Query exposing (ArticlesOptionalArguments)



-- Author Feed


feed : Int -> (Api.Response (Maybe Feed) -> msg) -> Effect msg
feed id_ msg =
    feedSelection id_
        |> Api.query msg
        |> Effect.loadAuthorFeed


feedSelection : Author.Id -> SelectionSet (Maybe Feed) RootQuery
feedSelection id_ =
    SelectionSet.succeed Feed.build
        |> with (authorById id_)
        |> with (authoredArticles id_)
        |> with (likedArticles id_)


authoredArticles : Int -> SelectionSet (List Article) RootQuery
authoredArticles id_ =
    Hasura.Query.articles
        (Articles.newestFirst >> authoredBy id_)
        Articles.articleSelection


likedArticles : Int -> SelectionSet (List Article) RootQuery
likedArticles id_ =
    Hasura.Query.articles
        (Articles.newestFirst >> likedBy id_)
        Articles.articleSelection


authoredBy : Int -> ArticlesOptionalArguments -> ArticlesOptionalArguments
authoredBy id_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (author Input.buildUsers_bool_exp)
        (id Input.buildInt_comparison_exp)
        (eq_ id_)


likedBy : Int -> ArticlesOptionalArguments -> ArticlesOptionalArguments
likedBy id_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (likes Input.buildLikes_bool_exp)
        (user_id Input.buildInt_comparison_exp)
        (eq_ id_)


authorById : Int -> SelectionSet (Maybe Author) RootQuery
authorById id_ =
    Hasura.Query.user { id = id_ } authorSelection


authorSelection : SelectionSet Author Users
authorSelection =
    SelectionSet.succeed Author.build
        |> with Users.id
        |> with Users.username
        |> with Users.profile_image
