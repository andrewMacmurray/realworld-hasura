module Form.Field exposing
    ( Config
    , Style
    , area
    , borderless
    , large
    , medium
    , small
    , text
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text


type alias Config inputs =
    { value : inputs -> String
    , update : inputs -> String -> inputs
    , label : String
    }


type Style
    = Large
    | Medium
    | Small
    | TextArea Border


type Border
    = Borderless
    | Bordered


large : Style
large =
    Large


medium : Style
medium =
    Medium


small : Style
small =
    Small


area : Style
area =
    TextArea Bordered


borderless : Style
borderless =
    TextArea Borderless


text : (inputs -> msg) -> Style -> Config inputs -> inputs -> Element msg
text msg style config inputs =
    let
        commonAttributes =
            [ Anchor.description config.label
            , padding Scale.small
            ]

        config_ =
            { onChange = config.update inputs >> msg
            , text = config.value inputs
            , placeholder = Just (placeholder config.label)
            , label = Input.labelHidden config.label
            }
    in
    case style of
        Small ->
            Input.text (Font.size Text.small :: commonAttributes) config_

        Medium ->
            Input.text (Font.size Text.medium :: commonAttributes) config_

        Large ->
            Input.text (Font.size Text.medium :: commonAttributes) config_

        TextArea border ->
            Input.multiline
                (List.concat
                    [ [ Font.size Text.small ]
                    , commonAttributes
                    , toAreaStyle border
                    ]
                )
                { onChange = config_.onChange
                , text = config_.text
                , placeholder = config_.placeholder
                , label = config_.label
                , spellcheck = True
                }


toAreaStyle border =
    case border of
        Borderless ->
            [ Border.widthEach { edges | bottom = 2 }
            , padding Scale.small
            , Border.rounded 0
            , Border.color Palette.lightGrey
            ]

        Bordered ->
            [ height (fill |> minimum 150) ]


placeholder : String -> Input.Placeholder msg
placeholder label =
    Input.placeholder [] (Element.text label)
