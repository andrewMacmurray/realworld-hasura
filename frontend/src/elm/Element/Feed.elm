module Element.Feed exposing (articles)

import Article exposing (Article)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Button as Button
import Element.Divider as Divider
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Route
import Tag
import User exposing (User)



-- Feed


type alias Options msg =
    { onLike : Article -> msg
    , onUnlike : Article -> msg
    , user : User
    , articles : List Article
    }


articles : Options msg -> Element msg
articles options =
    column
        [ spacing Scale.large
        , width fill
        ]
        (List.map (viewArticle options) options.articles)


viewArticle : Options msg -> Article -> Element msg
viewArticle options article =
    column
        [ anchor article
        , spacing Scale.medium
        , width fill
        ]
        [ row [ width fill ]
            [ column [ spacing Scale.medium, width fill ]
                [ row [ width fill ] [ profile article, likes options article ]
                , articleSummary article
                , row [ width fill ] [ readMore article, tags article ]
                ]
            ]
        , Divider.divider
        ]


likes : Options msg -> Article -> Element msg
likes options article =
    let
        likeCount =
            Article.likes article |> String.fromInt
    in
    el [ alignRight, alignTop ]
        (case options.user of
            User.Guest ->
                Button.decorative likeCount
                    |> Button.like
                    |> Button.toElement

            User.LoggedIn profile_ ->
                if Article.likedByMe profile_ article then
                    Button.button (options.onUnlike article) likeCount
                        |> Button.description ("unlike-" ++ Article.title article)
                        |> Button.like
                        |> Button.solid
                        |> Button.toElement

                else
                    Button.button (options.onLike article) likeCount
                        |> Button.description ("like-" ++ Article.title article)
                        |> Button.like
                        |> Button.toElement
        )


readMore : Article -> Element msg
readMore article =
    linkToArticle article (Text.label [] "READ MORE...")


articleSummary : Article -> Element msg
articleSummary article =
    linkToArticle article
        (column [ spacing Scale.small ]
            [ paragraph [] [ Text.subtitle [] (Article.title article) ]
            , Text.text [] (Article.about article)
            ]
        )


anchor : Article -> Attribute msg
anchor article =
    Anchor.description ("article-" ++ Article.title article)


profile : Article -> Element msg
profile article =
    authorLink article
        (row [ spacing Scale.small ]
            [ Avatar.large (Article.profileImage article)
            , column [ spacing Scale.small ]
                [ Text.link [ Text.green ] (Article.authorUsername article)
                , Text.date [] (Article.createdAt article)
                ]
            ]
        )


authorLink : Article -> Element msg -> Element msg
authorLink =
    Article.author >> Route.author >> Route.el


tags : Article -> Element msg
tags article =
    el [ width fill, alignBottom ]
        (wrappedRow
            [ spacing Scale.small
            , alignRight
            , paddingEach { edges | left = Scale.medium }
            ]
            (List.map viewTag (Article.tags article))
        )


viewTag : Tag.Tag -> Element msg
viewTag t =
    Route.link (Route.tagFeed t) [] ("#" ++ Tag.value t)


linkToArticle : Article -> Element msg -> Element msg
linkToArticle =
    Article.id >> Route.Article >> Route.el
