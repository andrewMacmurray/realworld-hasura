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
import Article.Component.Feed as Feed
import Article.Feed as Feed
import Article.Page as Page
import Context exposing (Context)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Background as Background
import Element.Border as Border
import Element.Layout as Layout
import Element.Loader as Loader
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Tab as Tab
import Element.Text as Text
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import Utils.Element as Element



-- Model


type alias Model =
    { pageLoad : PageLoad
    , popularTags : Api.Data (List Tag.Popular)
    , feed : Feed.Model
    , activeTab : Tab
    }


type Msg
    = LoadFeedResponseReceived (Api.Response Feed.Home)
    | GlobalFeedClicked
    | YourFeedClicked User.Profile
    | FeedMsg Feed.Msg


type PageLoad
    = Loading
    | Loaded


type Tab
    = Global
    | YourFeed
    | TagFeed Tag



-- Init


init : User -> Maybe Tag -> Page.Number -> ( Model, Effect Msg )
init user tag page_ =
    ( initialModel user page_ tag
    , fetchFeed user page_ tag
    )


fetchFeed : User -> Page.Number -> Maybe Tag -> Effect Msg
fetchFeed user page_ tag =
    case ( user, tag ) of
        ( _, Just tag_ ) ->
            loadFeed (Api.Articles.byTag page_ tag_)

        ( User.Guest, _ ) ->
            loadFeed (Api.Articles.all page_)

        ( User.Author profile_, _ ) ->
            fetchAuthorFeed page_ profile_


fetchAuthorFeed : Page.Number -> User.Profile -> Effect Msg
fetchAuthorFeed page_ profile_ =
    if User.isFollowingAuthors profile_ then
        loadFeed (Api.Articles.followedByAuthor profile_ page_)

    else
        loadFeed (Api.Articles.all page_)


loadFeed : SelectionSet Feed.Feed RootQuery -> Effect Msg
loadFeed where_ =
    Api.Articles.loadHomeFeed where_ LoadFeedResponseReceived


initialModel : User -> Page.Number -> Maybe Tag -> Model
initialModel user page_ tag =
    { pageLoad = Loading
    , activeTab = initTab user tag
    , feed = Feed.loading page_
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


handleFeedResponse : Model -> Api.Response Feed.Home -> Model
handleFeedResponse model res =
    { model
        | popularTags = Api.mapData .popularTags (Api.fromResponse res)
        , feed = Feed.fromResponse res model.feed
        , pageLoad = Loaded
    }


embedFeed : Model -> ( Feed.Model, Effect Feed.Msg ) -> ( Model, Effect Msg )
embedFeed =
    Feed.embed FeedMsg


loadGlobalFeed : Model -> ( Model, Effect Msg )
loadGlobalFeed model =
    Feed.load Api.Articles.all model.feed
        |> embedFeed { model | activeTab = Global }


loadYourFeed : User.Profile -> Model -> ( Model, Effect Msg )
loadYourFeed profile_ model =
    Feed.load (Api.Articles.followedByAuthor profile_) model.feed
        |> embedFeed { model | activeTab = YourFeed }



-- View


view : Context -> Model -> Element Msg
view context model =
    Layout.layout
        |> Layout.withBanner [ Background.color Palette.green ] (banner model)
        |> Layout.toPage context (pageContents context.user model)


banner : Model -> Element msg
banner model =
    column [ spacing Scale.medium, centerX ]
        [ el [ centerX ] (whiteHeadline "conduit")
        , el
            [ centerX
            , inFront
                (el [ centerX ]
                    (Loader.white
                        { message = "Loading..."
                        , visible = pageIsLoading model.pageLoad
                        }
                    )
                )
            ]
            (fadeInWhenPageLoaded model.pageLoad (whiteSubtitle "A place to share your knowledge"))
        ]


pageIsLoading : PageLoad -> Bool
pageIsLoading page =
    case page of
        Loading ->
            True

        Loaded ->
            False


isLoaded : Feed.Model -> Bool
isLoaded =
    not << Api.isLoading << .feed


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
            , fadeInWhenLoaded model.feed (popularTags model.popularTags)
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



-- Conditional Fades


fadeInWhenPageLoaded : PageLoad -> Element msg -> Element msg
fadeInWhenPageLoaded page element =
    case page of
        Loaded ->
            fadeIn element

        Loading ->
            hide element


fadeInWhenLoaded : Feed.Model -> Element msg -> Element msg
fadeInWhenLoaded feed element =
    if isLoaded feed then
        fadeIn element

    else
        hide element


fadeIn : Element msg -> Element msg
fadeIn =
    Animation.embed
        (Animation.fadeIn 200
            [ Animation.linear
            ]
        )


hide : Element msg -> Element msg
hide =
    el [ width fill, alpha 0 ]
