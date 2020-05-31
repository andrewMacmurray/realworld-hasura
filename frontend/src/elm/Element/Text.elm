module Element.Text exposing
    ( date
    , error
    , greenLink
    , greenSubtitle
    , greenTitle
    , headline
    , label
    , large
    , link
    , medium
    , small
    , subtitle
    , text
    , title
    )

import Date exposing (Date)
import Element
import Element.Font as Font
import Element.Palette as Palette
import Html.Attributes


type Color
    = Black
    | Green


headline : List (Element.Attribute msg) -> String -> Element.Element msg
headline attrs =
    title (attrs ++ [ Font.size extraLarge ])


greenTitle : List (Element.Attribute msg) -> String -> Element.Element msg
greenTitle attrs =
    title (attrs ++ [ toFontColor Green ])


title : List (Element.Attribute msg) -> String -> Element.Element msg
title attrs content =
    Element.el
        (List.concat
            [ [ Font.size large
              , toFontColor Black
              ]
            , attrs
            ]
        )
        (Element.text content)


greenSubtitle : List (Element.Attribute msg) -> String -> Element.Element msg
greenSubtitle attrs =
    subtitle (attrs ++ [ toFontColor Green ])


subtitle : List (Element.Attribute msg) -> String -> Element.Element msg
subtitle attrs content =
    Element.el
        (List.concat
            [ [ Font.size medium
              , Font.bold
              , toFontColor Black
              ]
            , attrs
            ]
        )
        (Element.text content)


toFontColor : Color -> Element.Attr decorative msg
toFontColor color =
    case color of
        Black ->
            Font.color Palette.black

        Green ->
            Font.color Palette.green


date : List (Element.Attribute msg) -> Date -> Element.Element msg
date attrs date_ =
    label attrs (formatDate date_)


label : List (Element.Attribute msg) -> String -> Element.Element msg
label attrs content =
    text
        (List.concat
            [ [ Font.size extraSmall
              , Font.letterSpacing 0.6
              ]
            , attrs
            ]
        )
        (String.toUpper content)


formatDate : Date -> String
formatDate =
    Date.format "EEE MMM d y"


text : List (Element.Attribute msg) -> String -> Element.Element msg
text attrs content =
    Element.el
        (List.concat
            [ [ Font.size small
              , Element.pointer
              , Font.color Palette.grey
              ]
            , attrs
            ]
        )
        (Element.text content)


error : List (Element.Attribute msg) -> String -> Element.Element msg
error attrs content =
    text (attrs ++ [ Font.color Palette.red ]) content


greenLink : List (Element.Attribute msg) -> String -> Element.Element msg
greenLink =
    link_ Green


link : List (Element.Attribute msg) -> String -> Element.Element msg
link =
    link_ Black


link_ : Color -> List (Element.Attribute msg) -> String -> Element.Element msg
link_ color attrs content =
    let
        fontColor =
            case color of
                Black ->
                    Font.color Palette.grey

                Green ->
                    Font.color Palette.green

        hoverColor =
            case color of
                Black ->
                    Font.color Palette.black

                Green ->
                    Font.color Palette.darkGreen
    in
    Element.el
        (List.concat
            [ [ Font.size small
              , Element.pointer
              , fontColor
              , underlineOnHover
              , Element.mouseOver [ hoverColor ]
              ]
            , attrs
            ]
        )
        (Element.text content)


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
