module Element.FancyText exposing
    ( asLink
    , date
    , error
    , green
    , headline
    , label
    , large
    , link
    , medium
    , regular
    , small
    , subtitle
    , text
    , title
    , toElement
    , white
    )

import Date exposing (Date)
import Element exposing (Element)
import Element.Font as Font
import Element.Palette as Palette
import Html.Attributes


type alias Options =
    { color : Color
    , size : Size
    , weight : Weight
    , isLink : Bool
    }


type Weight
    = Regular
    | Bold


type Size
    = Label
    | Body
    | Subtitle
    | Title
    | Headline


type Color
    = Black
    | Grey
    | Green
    | Red
    | White



-- Default Options


text_ : List (Options -> Options) -> List (Options -> Options) -> String -> Element msg
text_ base extras =
    (base ++ extras)
        |> List.foldl identity defaultOptions
        |> toElement


defaultOptions : Options
defaultOptions =
    { color = Grey
    , size = Body
    , weight = Regular
    , isLink = False
    }



-- Configure


green : Options -> Options
green =
    withColor Green


white : Options -> Options
white =
    withColor White


withSize : Size -> Options -> Options
withSize size options =
    { options | size = size }


withColor : Color -> Options -> Options
withColor color options =
    { options | color = color }


bold : Options -> Options
bold options =
    { options | weight = Bold }


regular : Options -> Options
regular options =
    { options | weight = Regular }


asLink : Options -> Options
asLink options =
    { options | isLink = True }



-- Standard Settings


headline : List (Options -> Options) -> String -> Element msg
headline opts =
    text_ [ withSize Headline ] opts


title : List (Options -> Options) -> String -> Element msg
title opts =
    text_ [ withSize Title, withColor Black ] opts


subtitle : List (Options -> Options) -> String -> Element msg
subtitle opts =
    text_
        [ withSize Subtitle
        , withColor Black
        , bold
        ]
        opts


text : List (Options -> Options) -> String -> Element msg
text opts =
    text_ [] opts


label : List (Options -> Options) -> String -> Element msg
label opts =
    text_ [ withSize Label ] opts << String.toUpper


error : List (Options -> Options) -> String -> Element msg
error opts =
    text_ [ withColor Red ] opts


link : List (Options -> Options) -> String -> Element msg
link opts =
    text_ [ withColor Grey, asLink ] opts


date : List (Options -> Options) -> Date -> Element msg
date opts d =
    label opts (formatDate d)



-- Render


toElement : Options -> String -> Element.Element msg
toElement options content =
    Element.el
        (List.concat
            [ [ toFontColor2 options
              , toSize options
              , toWeight options
              , toLetterSpacing options
              ]
            , toLinkStyles options
            ]
        )
        (Element.text content)


toFontColor2 : Options -> Element.Attr decorative msg
toFontColor2 options =
    case options.color of
        Black ->
            Font.color Palette.black

        Grey ->
            Font.color Palette.grey

        Green ->
            Font.color Palette.green

        Red ->
            Font.color Palette.red

        White ->
            Font.color Palette.white


toSize : Options -> Element.Attr decorative msg
toSize options =
    case options.size of
        Label ->
            Font.size extraSmall

        Body ->
            Font.size small

        Subtitle ->
            Font.size medium

        Title ->
            Font.size large

        Headline ->
            Font.size extraLarge


toWeight : Options -> Element.Attribute msg
toWeight options =
    case options.weight of
        Bold ->
            Font.bold

        Regular ->
            Font.regular


toLetterSpacing : Options -> Element.Attribute msg
toLetterSpacing options =
    case options.size of
        Label ->
            Font.letterSpacing 0.6

        _ ->
            Font.letterSpacing 0


toLinkStyles : Options -> List (Element.Attribute msg)
toLinkStyles options =
    if options.isLink then
        [ underlineOnHover
        , Element.pointer
        , Element.mouseOver [ toHoverColors options ]
        ]

    else
        []


toHoverColors : Options -> Element.Attr decorative msg
toHoverColors options =
    case options.color of
        Black ->
            Font.color Palette.grey

        Grey ->
            Font.color Palette.black

        Green ->
            Font.color Palette.darkGreen

        Red ->
            Font.color Palette.darkRed

        White ->
            Font.color Palette.grey


formatDate : Date -> String
formatDate =
    Date.format "EEE MMM d y"


underlineOnHover : Element.Attribute msg
underlineOnHover =
    Element.htmlAttribute (Html.Attributes.class "underline-hover")


extraLarge : number
extraLarge =
    64


large : number
large =
    32


medium : number
medium =
    22


small : number
small =
    16


extraSmall : number
extraSmall =
    10
