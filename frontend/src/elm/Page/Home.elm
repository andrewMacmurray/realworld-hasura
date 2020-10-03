module Page.Home exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Animation
import Animation.Named as Animation
import Api
import Api.Articles
import Article exposing (Article)
import Article.Feed as Feed
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Background as Background
import Element.Border as Border
import Element.Layout as Layout
import Element.Loading as Loading
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Tab as Tab
import Element.Text as Text
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import Utils.Element as Element



-- Model


type alias Model =
    { popularTags : Api.Data (List Tag.Popular)
    , feed : Feed.Model
    , activeTab : Tab
    }


type Msg
    = LoadFeedResponseReceived (Api.Response Article.Feed)
    | GlobalFeedClicked
    | YourFeedClicked User.Profile
    | FeedMsg Feed.Msg


type Tab
    = Global
    | YourFeed
    | TagFeed Tag



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

        ( User.Author profile_, _ ) ->
            Api.Articles.loadFeed (Api.Articles.followedByAuthor profile_) LoadFeedResponseReceived


initialModel : User -> Maybe Tag -> Model
initialModel user tag =
    { activeTab = initTab user tag
    , feed = Feed.loading
    , popularTags = Api.Loading
    }


initTab : User -> Maybe Tag -> Tab
initTab user tag =
    case ( user, tag ) of
        ( _, Just t ) ->
            TagFeed t

        ( User.Author _, _ ) ->
            YourFeed

        ( User.Guest, _ ) ->
            Global



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LoadFeedResponseReceived res ->
            ( handleFeedResponse model res
            , Effect.none
            )

        GlobalFeedClicked ->
            loadGlobalFeed model

        YourFeedClicked profile_ ->
            loadYourFeed profile_ model

        FeedMsg msg_ ->
            Feed.update FeedMsg msg_ model


handleFeedResponse : Model -> Api.Response Article.Feed -> Model
handleFeedResponse model res =
    { model
        | popularTags = Api.mapData .popularTags (Api.fromResponse res)
        , feed = Feed.fromResponse res
    }


embedFeed : Model -> ( Feed.Model, Effect Feed.Msg ) -> ( Model, Effect Msg )
embedFeed =
    Feed.embed FeedMsg


loadGlobalFeed : Model -> ( Model, Effect Msg )
loadGlobalFeed model =
    Feed.load Api.Articles.all
        |> embedFeed { model | activeTab = Global }


loadYourFeed : User.Profile -> Model -> ( Model, Effect Msg )
loadYourFeed profile_ model =
    Api.Articles.followedByAuthor profile_
        |> Feed.load
        |> embedFeed { model | activeTab = YourFeed }



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> Layout.withBanner [ Background.color Palette.green ] banner
        |> Layout.toPage (pageContents user model)


banner : Element msg
banner =
    column [ spacing Scale.medium, centerX ]
        [ el [ centerX ] (whiteHeadline "conduit")
        , el
            [ centerX
            , inFront (el [ centerX ] Loading.spinner)
            ]
            (el [ alpha 0 ] (whiteSubtitle "A place to share your knowledge"))
        ]


whiteSubtitle : String -> Element msg
whiteSubtitle =
    Text.text [ Text.regular, Text.white ]


whiteHeadline : String -> Element msg
whiteHeadline =
    Text.headline [ Text.white ]



-- Links


tabs : User -> Tab -> Element Msg
tabs user feed =
    case user of
        User.Guest ->
            Tab.tabs (guestTabs feed)

        User.Author profile_ ->
            Tab.tabs (userTabs profile_ feed)


userTabs : User.Profile -> Tab -> List (Element Msg)
userTabs profile_ tab =
    case tab of
        Global ->
            [ Tab.active "global feed"
            , Tab.link (YourFeedClicked profile_) "your feed"
            ]

        YourFeed ->
            [ Tab.link GlobalFeedClicked "global feed"
            , Tab.active "your feed"
            ]

        TagFeed tag_ ->
            [ Tab.link GlobalFeedClicked "global feed"
            , Tab.link (YourFeedClicked profile_) "your feed"
            , tagTab tag_
            ]


guestTabs : Tab -> List (Element Msg)
guestTabs tab =
    case tab of
        Global ->
            [ Tab.active "Global Feed"
            ]

        TagFeed tag_ ->
            [ Tab.link GlobalFeedClicked "Global Feed"
            , tagTab tag_
            ]

        YourFeed ->
            []


tagTab : Tag -> Element msg
tagTab tag =
    Tab.active ("#" ++ String.toLower (Tag.value tag))



-- Page


pageContents : User -> Model -> Element Msg
pageContents user model =
    Animation.node
        (Animation.fadeIn 500
            [ Animation.delay 500
            , Animation.linear
            ]
        )
        row
        [ width fill, spacing Scale.large ]
        [ column [ width fill, alignTop, spacing Scale.large ]
            [ tabs user model.activeTab
            , viewFeed user model.feed
            ]
        , Element.desktopOnly column
            [ Anchor.description "popular-tags"
            , alignTop
            , spacing Scale.extraLarge
            , width (fill |> maximum 300)
            ]
            [ Text.title [] "Popular Tags"
            , popularTags model.popularTags
            ]
        ]


viewFeed : User -> Feed.Model -> Element Msg
viewFeed user feed =
    Feed.view
        { feed = feed
        , user = user
        , msg = FeedMsg
        }


popularTags : Api.Data (List Tag.Popular) -> Element msg
popularTags tags =
    case tags of
        Api.Success tags_ ->
            wrappedRow [ spacing Scale.small ] (List.map popularTag tags_)

        _ ->
            none


popularTag : Tag.Popular -> Element msg
popularTag { tag, count } =
    Route.el (Route.tagFeed tag)
        (row
            [ spacing 4
            , Anchor.description ("popular-" ++ Tag.value tag)
            ]
            [ Text.link [] ("#" ++ Tag.value tag)
            , tagCount count
            ]
        )


tagCount : Int -> Element msg
tagCount n =
    el
        [ Background.color Palette.deepGreen
        , Border.rounded 10000
        , alignTop
        , moveUp 5
        , width (px 18)
        , height (px 18)
        ]
        (el [ centerX, centerY ] (whiteLabel (String.fromInt n)))


whiteLabel : String -> Element msg
whiteLabel =
    Text.label [ Text.white ]
