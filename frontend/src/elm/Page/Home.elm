module Page.Home exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Article exposing (Article)
import Article.Feed as Feed
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Background as Background
import Element.Border as Border
import Element.Divider as Divider
import Element.Events exposing (onClick)
import Element.Layout as Layout
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import Utils.String as String
import Utils.Update exposing (updateWith)
import WebData exposing (WebData)



-- Model


type alias Model =
    { popularTags : WebData (List Tag.Popular)
    , feed : Feed.Model
    , tab : Tab
    }


type Msg
    = LoadFeedResponseReceived (Api.Response Article.Feed)
    | GlobalFeedClicked
    | UserFeedClicked User.Profile
    | FeedMsg Feed.Msg


type Tab
    = GlobalTab
    | UserTab
    | TagTab Tag



-- Init


init : User -> Maybe Tag -> ( Model, Effect Msg )
init user tag =
    ( initialModel user tag
    , fetchFeed user tag
    )


fetchFeed : User -> Maybe Tag -> Effect Msg
fetchFeed user tag =
    case ( user, tag ) of
        ( _, Just tag_ ) ->
            Api.Articles.loadFeed (Api.Articles.byTag tag_) LoadFeedResponseReceived

        ( User.Guest, _ ) ->
            Api.Articles.loadFeed Api.Articles.all LoadFeedResponseReceived

        ( User.LoggedIn profile_, _ ) ->
            Api.Articles.loadFeed (Api.Articles.followedByAuthor profile_) LoadFeedResponseReceived


initialModel : User -> Maybe Tag -> Model
initialModel user tag =
    { tab = initTab user tag
    , feed = Feed.loading
    , popularTags = WebData.Loading
    }


initTab : User -> Maybe Tag -> Tab
initTab user tag =
    case ( user, tag ) of
        ( _, Just t ) ->
            TagTab t

        ( User.LoggedIn _, _ ) ->
            UserTab

        ( User.Guest, _ ) ->
            GlobalTab



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LoadFeedResponseReceived (Ok { popularTags, articles }) ->
            ( { model | popularTags = WebData.Success popularTags, feed = Feed.loaded articles }
            , Effect.none
            )

        LoadFeedResponseReceived (Err _) ->
            ( { model | popularTags = WebData.Failure, feed = Feed.failure }
            , Effect.none
            )

        GlobalFeedClicked ->
            Feed.load Api.Articles.all
                |> updateFeed model
                |> updateModel (\m -> { m | tab = GlobalTab })

        UserFeedClicked profile_ ->
            Feed.load (Api.Articles.followedByAuthor profile_)
                |> updateFeed model
                |> updateModel (\m -> { m | tab = UserTab })

        FeedMsg msg_ ->
            Feed.update msg_ model.feed |> updateFeed model


updateFeed : Model -> ( Feed.Model, Effect Feed.Msg ) -> ( Model, Effect Msg )
updateFeed model =
    updateWith (\feed -> { model | feed = feed }) FeedMsg


updateModel =
    Tuple.mapFirst



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> Layout.withBanner [ Background.color Palette.green ] banner
        |> Layout.toElement [ pageContents user model ]


banner : Element msg
banner =
    column [ spacing Scale.medium, centerX ]
        [ el [ centerX ] (whiteHeadline "conduit")
        , el [ centerX ] (whiteSubtitle "A place to share your knowledge")
        ]


whiteSubtitle : String -> Element msg
whiteSubtitle =
    Text.subtitle [ Text.regular, Text.white ]


whiteHeadline : String -> Element msg
whiteHeadline =
    Text.headline [ Text.white ]



-- Links


feedLinks : User -> Tab -> List (Element Msg)
feedLinks user feed =
    case user of
        User.Guest ->
            guestLinks feed

        User.LoggedIn profile_ ->
            userLinks profile_ feed


userLinks : User.Profile -> Tab -> List (Element Msg)
userLinks profile_ tab =
    case tab of
        GlobalTab ->
            [ greenSubtitle "Global Feed"
            , userFeedLink profile_ (subtitleLink "Your Feed")
            ]

        UserTab ->
            [ globalFeedLink (subtitleLink "Global Feed")
            , el [] (greenSubtitle "Your Feed")
            ]

        TagTab tag_ ->
            [ globalFeedLink (subtitleLink "Global Feed")
            , userFeedLink profile_ (subtitleLink "Your Feed")
            , greenSubtitle ("#" ++ String.capitalize (Tag.value tag_))
            ]


guestLinks : Tab -> List (Element Msg)
guestLinks tab =
    case tab of
        GlobalTab ->
            [ greenSubtitle "Global Feed"
            ]

        TagTab tag_ ->
            [ globalFeedLink (subtitleLink "Global Feed")
            , greenSubtitle ("#" ++ String.capitalize (Tag.value tag_))
            ]

        UserTab ->
            []


globalFeedLink : Element Msg -> Element Msg
globalFeedLink =
    el [ onClick GlobalFeedClicked ]


userFeedLink : User.Profile -> Element Msg -> Element Msg
userFeedLink profile_ =
    el [ onClick (UserFeedClicked profile_) ]



-- Page


pageContents : User -> Model -> Element Msg
pageContents user model =
    row [ width fill, spacing Scale.large ]
        [ column
            [ width fill
            , spacing Scale.large
            ]
            [ row [ spacing Scale.large ] (feedLinks user model.tab)
            , Divider.divider
            , viewFeed user model.feed
            ]
        , column
            [ Anchor.description "popular-tags"
            , alignTop
            , spacing Scale.large
            , width (fill |> maximum 300)
            ]
            [ Text.title [] "Popular Tags"
            , viewPopularTags model.popularTags
            ]
        ]


viewFeed : User -> Feed.Model -> Element Msg
viewFeed user feed =
    Feed.view
        { feed = feed
        , user = user
        , msg = FeedMsg
        }


viewPopularTags : WebData (List Tag.Popular) -> Element msg
viewPopularTags tags =
    case tags of
        WebData.Loading ->
            none

        WebData.Failure ->
            none

        WebData.Success tags_ ->
            wrappedRow [ spacing Scale.small ] (List.map viewPopularTag tags_)


viewPopularTag : Tag.Popular -> Element msg
viewPopularTag t =
    Route.el (Route.tagFeed t.tag)
        (row
            [ spacing 4
            , Anchor.description ("popular-" ++ Tag.value t.tag)
            ]
            [ Text.link [] ("#" ++ Tag.value t.tag)
            , el
                [ Background.color Palette.deepGreen
                , Border.rounded 10000
                , alignTop
                , moveUp 5
                , width (px 18)
                , height (px 18)
                ]
                (el [ centerX, centerY ] (whiteLabel (String.fromInt t.count)))
            ]
        )


whiteLabel : String -> Element msg
whiteLabel =
    Text.label [ Text.white ]


subtitleLink : String -> Element msg
subtitleLink =
    Text.subtitle [ Text.asLink ]


greenSubtitle : String -> Element msg
greenSubtitle =
    Text.subtitle [ Text.green ]
