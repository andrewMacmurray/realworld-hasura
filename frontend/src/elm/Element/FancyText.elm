module Element.FancyText exposing
    ( asLink
    , date
    , el
    , error
    , green
    , greenLink
    , greenSubtitle
    , greenTitle
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
    , white
    )

import Date exposing (Date)
import Element
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


text_ : Options
text_ =
    { color = Grey
    , size = Body
    , weight = Regular
    , isLink = False
    }



-- Configure


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


headline =
    text_ |> withSize Headline


greenTitle =
    title |> withColor Green


title =
    text_
        |> withSize Title
        |> withColor Black


greenSubtitle =
    subtitle |> withColor Green


subtitle =
    text_
        |> withSize Subtitle
        |> withColor Black
        |> bold


green =
    withColor Green


white =
    withColor White


label =
    text_ |> withSize Label


text =
    text_


error =
    text_ |> withColor Red |> el


greenLink =
    link |> withColor Green


link =
    text_ |> withColor Black |> asLink



-- Render


el : Options -> String -> Element.Element msg
el options content =
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



--date : List (Element.Attribute msg) -> Date -> Element.Element msg


date attrs date_ =
    Debug.todo ""



--label attrs (formatDate date_)
--text
--    (List.concat
--        [ [ Font.size extraSmall
--          , Font.letterSpacing 0.6
--          ]
--        , attrs
--        ]
--    )
--    (String.toUpper content)


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
