module Page.ArticleTest exposing (..)

import Article exposing (Article)
import Article.Author exposing (Author)
import Article.Comment exposing (Comment)
import Expect exposing (Expectation)
import Helpers
import Ports
import Program exposing (defaultUser)
import Program.Expect exposing (contains, hasNoEls)
import Program.Selector exposing (el)
import ProgramTest exposing (ensureView, ensureViewHas, expectView, expectViewHas)
import Route
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (containing, text)


suite : Test
suite =
    describe "Article Page"
        [ test "User sees article on successful load" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Ok (Just article))
                    |> Program.start
                    |> expectViewHas [ el "article-title" ]
        , test "User sees not found message if server does not find article for given id" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Ok Nothing)
                    |> Program.start
                    |> expectViewHas [ el "not-found-message" ]
        , test "User sees failure message if server returns an error" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Err Helpers.serverError)
                    |> Program.start
                    |> expectViewHas [ el "error-message" ]
        , test "Logged in user can follow an author" <|
            \_ ->
                Program.withPage articlePage
                    |> withArticle anArticle
                    |> Program.loggedInWithUser "amacmurray"
                    |> Program.start
                    |> expectViewHas [ el "follow-someone" ]
        , test "Logged in user can unfollow a previously followed author" <|
            \_ ->
                Program.withPage articlePage
                    |> withArticle anArticle
                    |> Program.loggedInWithDetails { defaultUser | following = [ 2 ] }
                    |> Program.start
                    |> expectViewHas [ el "unfollow-someone" ]
        , test "Logged in user can post a comment" <|
            \_ ->
                Program.withPage articlePage
                    |> withArticle anArticle
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> expectViewHas [ el "comments", el "post-new-comment" ]
        , test "Guest user cannot post comment" <|
            \_ ->
                Program.withPage articlePage
                    |> withArticle anArticle
                    |> Program.start
                    |> ensureViewHas [ el "comments" ]
                    |> expectView (hasNoEls "post-new-comment")
        , test "User can perform actions on their own comments" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.loggedInWithDetails defaultUser
                    |> withArticle
                        (articleWithComments
                            [ comment anotherAuthor
                            , comment (toAuthor defaultUser)
                            ]
                        )
                    |> Program.start
                    |> ensureView (contains 2 "comment")
                    |> expectView (hasEditableCommentFor defaultUser)
        , test "User can perform actions on their own article" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.loggedInWithDetails defaultUser
                    |> withArticle (articleBy defaultUser.id "by me")
                    |> Program.start
                    |> ensureView (contains 1 "edit-article")
                    |> expectView (contains 1 "delete-article")
        ]


hasEditableCommentFor : Ports.User -> Query.Single msg -> Expectation
hasEditableCommentFor user =
    Query.has
        [ el "comment"
        , containing [ text user.username ]
        , containing [ el "comment-actions" ]
        ]


articleWithComments : List Comment -> Article
articleWithComments =
    Helpers.articleWithComments


comment : Author -> Comment
comment =
    Helpers.comment


toAuthor : Ports.User -> Author
toAuthor user =
    Helpers.author user.id user.username


anotherAuthor : Author
anotherAuthor =
    Helpers.author 12 "crusty"


withArticle : Article -> Program.Options -> Program.Options
withArticle =
    Program.simulateArticle << Ok << Just


anArticle : Article
anArticle =
    articleBy 2 "someone"


articlePage : Route.Route
articlePage =
    Route.Article 1


articleBy : Int -> String -> Article
articleBy =
    Helpers.articleBy


article : Article
article =
    Helpers.article "An Article"
