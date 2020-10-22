module Element.Markdown exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Html
import Html.Attributes
import Markdown.Block as Block exposing (ListItem(..), Task(..))
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer


view : String -> List (Element msg)
view =
    Markdown.Parser.parse
        >> Result.mapError (List.map Markdown.Parser.deadEndToString >> String.join "\n")
        >> Result.andThen (Markdown.Renderer.render renderer)
        >> Result.withDefault []


renderer : Markdown.Renderer.Renderer (Element msg)
renderer =
    { heading = heading
    , paragraph = paragraph []
    , thematicBreak = none
    , text = \value -> paragraph [] [ Text.text [] value ]
    , strong = paragraph [ Font.bold ]
    , emphasis = paragraph [ Font.italic ]
    , codeSpan = code
    , link =
        \{ title, destination } body ->
            newTabLink []
                { url = destination
                , label =
                    paragraph
                        [ Font.color (Element.rgb255 0 0 255)
                        , htmlAttribute (Html.Attributes.style "overflow-wrap" "break-word")
                        , htmlAttribute (Html.Attributes.style "word-break" "break-word")
                        ]
                        body
                }
    , hardLineBreak = html (Html.br [] [])
    , image = toImage
    , blockQuote =
        Element.paragraph
            [ Border.widthEach { edges | left = 10 }
            , padding Scale.medium
            , Border.color Palette.black
            , Background.color Palette.lightGrey
            ]
    , unorderedList = unorderedList
    , orderedList =
        \startingIndex items ->
            column [ spacing Scale.medium ]
                (items
                    |> List.indexedMap
                        (\index itemBlocks ->
                            paragraph [ spacing Scale.medium, width fill ]
                                [ paragraph [ alignTop ] (text (String.fromInt (index + startingIndex) ++ " ") :: itemBlocks) ]
                        )
                )
    , codeBlock = codeBlock
    , table = column [ width fill ]
    , tableHeader = column [ Font.bold, width fill, Font.center ]
    , tableBody = column [ width fill ]
    , tableRow = row [ height fill, width fill ]
    , tableHeaderCell = \_ children -> paragraph tableBorder children
    , tableCell = \_ children -> paragraph tableBorder children
    , html = Markdown.Html.oneOf []
    }


toImage : { title : Maybe String, src : String, alt : String } -> Element msg
toImage img =
    case img.title of
        Just _ ->
            image [ width fill ] { src = img.src, description = img.alt }

        Nothing ->
            image [ width fill ] { src = img.src, description = img.alt }


unorderedList : List (ListItem (Element msg)) -> Element msg
unorderedList items =
    column [ spacing Scale.small ] (List.map unorderedItem items)


unorderedItem : ListItem (Element msg) -> Element msg
unorderedItem (ListItem task children) =
    paragraph [ spacing Scale.small, width fill ]
        [ row [ alignTop, width fill ]
            ((case task of
                IncompleteTask ->
                    Element.Input.defaultCheckbox False

                CompletedTask ->
                    Element.Input.defaultCheckbox True

                NoTask ->
                    text "•"
             )
                :: text " "
                :: children
            )
        ]


alternateTableRowBackground : Element.Color
alternateTableRowBackground =
    Element.rgb255 245 247 249


tableBorder : List (Element.Attr () msg)
tableBorder =
    [ Border.color Palette.lightGrey
    , paddingXY Scale.small Scale.medium
    , Border.width 1
    , Border.solid
    , height fill
    , Background.color Palette.black
    , width fill
    ]


rawTextToId : String -> String
rawTextToId =
    String.split " "
        >> String.join "-"
        >> String.toLower


heading : { level : Block.HeadingLevel, rawText : String, children : List (Element msg) } -> Element msg
heading { level, rawText, children } =
    paragraph []
        [ case level of
            Block.H1 ->
                Text.title [ Text.bold ] rawText

            Block.H2 ->
                Text.title [] rawText

            Block.H3 ->
                Text.subtitle [ Text.bold ] rawText

            Block.H4 ->
                Text.subtitle [ Text.regular ] rawText

            _ ->
                Text.text [ Text.bold ] rawText
        ]


code : String -> Element msg
code snippet =
    Element.el
        [ Background.color (rgba 0 0 0 0.04)
        , Border.rounded 2
        , paddingXY 5 3
        ]
        (Element.text snippet)


codeBlock : { body : String, language : Maybe String } -> Element msg
codeBlock details =
    paragraph
        [ Background.color (Element.rgba 0 0 0 0.03)
        , htmlAttribute (Html.Attributes.style "white-space" "pre-wrap")
        , htmlAttribute (Html.Attributes.style "overflow-wrap" "break-word")
        , htmlAttribute (Html.Attributes.style "word-break" "break-word")
        , padding 20
        ]
        [ html (Html.code [] [ Html.text details.body ]) ]
