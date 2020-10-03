module Element.Text exposing
    ( Option
    , asLink
    , black
    , bold
    , darkGreen
    , date
    , description
    , error
    , fadeIn
    , green
    , grey
    , headline
    , label
    , large
    , link
    , medium
    , pointer
    , regular
    , small
    , subtitle
    , text
    , title
    , toElement
    , white
    )

import Animation
import Animation.Named as Animation
import Date exposing (Date)
import Element exposing (Attribute, Element)
import Element.Anchor as Anchor
import Element.Font as Font
import Element.Palette as Palette
import Html.Attributes



-- Options


type alias Option =
    Properties_ -> Properties_


type alias Properties_ =
    { color : Color
    , scale : Scale
    , weight : Weight
    , isLink : Bool
    , showPointer : Bool
    , description : Maybe String
    , font : Font
    }


type Weight
    = Regular
    | Bold


type Scale
    = Label
    | Text
    | Subtitle
    | TertiaryTitle
    | Title
    | Headline


type Color
    = Black
    | Grey
    | Green
    | DarkGreen
    | Red
    | White


type Font
    = Heading
    | Body



-- Default Options


text_ : List Option -> List Option -> String -> Element msg
text_ base extras =
    (base ++ extras)
        |> List.foldl identity defaultProperties
        |> toElement


defaultProperties : Properties_
defaultProperties =
    { color = Grey
    , scale = Text
    , weight = Regular
    , isLink = False
    , showPointer = False
    , description = Nothing
    , font = Body
    }



-- Configure


green : Option
green =
    withColor Green


darkGreen : Option
darkGreen =
    withColor DarkGreen


white : Option
white =
    withColor White


black : Option
black =
    withColor Black


grey : Option
grey =
    withColor Grey


pointer : Option
pointer properties =
    { properties | showPointer = True }


withSize : Scale -> Option
withSize size_ properties =
    { properties | scale = size_ }


withColor : Color -> Option
withColor color properties =
    { properties | color = color }


headingFont : Option
headingFont properties =
    { properties | font = Heading }


bodyFont : Option
bodyFont properties =
    { properties | font = Body }


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
    text_ [ withSize Headline, headingFont ]


title : List Option -> String -> Element msg
title =
    text_ [ withSize Title, withColor Black, headingFont ]


subtitle : List Option -> String -> Element msg
subtitle =
    text_ [ withSize Subtitle, withColor Black, bold, headingFont ]


text : List Option -> String -> Element msg
text =
    text_ [ bodyFont ]


label : List Option -> String -> Element msg
label options =
    text_ [ withSize Label, headingFont ] options << String.toUpper


error : List Option -> String -> Element msg
error =
    text_ [ withColor Red, bodyFont ]


link : List Option -> String -> Element msg
link =
    text_ [ withColor Grey, asLink, bodyFont ]


date : List Option -> Date -> Element msg
date options =
    label options << formatDate



-- Animation Utils


fadeIn : Element msg -> Element msg
fadeIn =
    Animation.embed (Animation.fadeIn 300 [ Animation.delay 100 ])



-- Render


toElement : Properties_ -> String -> Element msg
toElement properties content =
    Element.el
        (List.concat
            [ [ fontColor properties
              , size properties
              , weight properties
              , letterSpacing properties
              , fontFamily properties
              ]
            , showPointer properties
            , anchor properties
            , linkStyles properties
            ]
        )
        (Element.text content)


showPointer : Properties_ -> List (Attribute msg)
showPointer properties =
    if properties.showPointer then
        [ Element.pointer ]

    else
        []


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

        DarkGreen ->
            Font.color Palette.darkGreen

        Red ->
            Font.color Palette.red

        White ->
            Font.color Palette.white


fontFamily : Properties_ -> Attribute msg
fontFamily properties =
    case properties.font of
        Heading ->
            openSans

        Body ->
            abeezee


size : Properties_ -> Element.Attr decorative msg
size properties =
    case properties.scale of
        Label ->
            Font.size extraSmall

        Text ->
            Font.size small

        TertiaryTitle ->
            Font.size medium

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
    case properties.scale of
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

        DarkGreen ->
            Font.color Palette.green

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


abeezee : Attribute msg
abeezee =
    Font.family
        [ Font.typeface "ABeeZee"
        , Font.sansSerif
        ]


openSans : Attribute msg
openSans =
    Font.family
        [ Font.typeface "Open Sans"
        , Font.sansSerif
        ]
