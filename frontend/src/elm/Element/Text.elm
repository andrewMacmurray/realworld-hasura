module Element.Text exposing
    ( asLink
    , bold
    , date
    , description
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
import Element.Anchor as Anchor
import Element.Font as Font
import Element.Palette as Palette
import Html.Attributes



-- Options


type alias Option =
    Properties_ -> Properties_


type alias Properties_ =
    { color : Color
    , size : Size
    , weight : Weight
    , isLink : Bool
    , description : Maybe String
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


text_ : List Option -> List Option -> String -> Element msg
text_ base extras =
    (base ++ extras)
        |> List.foldl identity defaultProperties
        |> toElement


defaultProperties : Properties_
defaultProperties =
    { color = Grey
    , size = Body
    , weight = Regular
    , isLink = False
    , description = Nothing
    }



-- Configure


green : Option
green =
    withColor Green


white : Option
white =
    withColor White


withSize : Size -> Option
withSize size_ properties =
    { properties | size = size_ }


withColor : Color -> Option
withColor color properties =
    { properties | color = color }


bold : Option
bold properties =
    { properties | weight = Bold }


regular : Option
regular properties =
    { properties | weight = Regular }


asLink : Option
asLink properties =
    { properties | isLink = True }


description : String -> Option
description d properties =
    { properties | description = Just d }



-- Standard Settings


headline : List Option -> String -> Element msg
headline =
    text_ [ withSize Headline ]


title : List Option -> String -> Element msg
title =
    text_ [ withSize Title, withColor Black ]


subtitle : List Option -> String -> Element msg
subtitle =
    text_ [ withSize Subtitle, withColor Black, bold ]


text : List Option -> String -> Element msg
text =
    text_ []


label : List Option -> String -> Element msg
label options =
    text_ [ withSize Label ] options << String.toUpper


error : List Option -> String -> Element msg
error =
    text_ [ withColor Red ]


link : List Option -> String -> Element msg
link =
    text_ [ withColor Grey, asLink ]


date : List Option -> Date -> Element msg
date options =
    label options << formatDate



-- Render


toElement : Properties_ -> String -> Element.Element msg
toElement properties content =
    Element.el
        (List.concat
            [ [ fontColor properties
              , size properties
              , weight properties
              , letterSpacing properties
              ]
            , anchor properties
            , linkStyles properties
            ]
        )
        (Element.text content)


anchor : Properties_ -> List (Element.Attribute msg)
anchor properties =
    case properties.description of
        Just d ->
            [ Anchor.description d ]

        Nothing ->
            []


fontColor : Properties_ -> Element.Attr decorative msg
fontColor properties =
    case properties.color of
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


size : Properties_ -> Element.Attr decorative msg
size properties =
    case properties.size of
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


weight : Properties_ -> Element.Attribute msg
weight properties =
    case properties.weight of
        Bold ->
            Font.bold

        Regular ->
            Font.regular


letterSpacing : Properties_ -> Element.Attribute msg
letterSpacing properties =
    case properties.size of
        Label ->
            Font.letterSpacing 0.6

        _ ->
            Font.letterSpacing 0


linkStyles : Properties_ -> List (Element.Attribute msg)
linkStyles properties =
    if properties.isLink then
        [ underlineOnHover
        , Element.pointer
        , Element.mouseOver [ hoverColors properties ]
        ]

    else
        []


hoverColors : Properties_ -> Element.Attr decorative msg
hoverColors properties =
    case properties.color of
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
