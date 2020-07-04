module Form.View.Field exposing
    ( Style
    , View
    , area
    , borderless
    , large
    , medium
    , small
    , toElement
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Form.Field as Field exposing (Field)



-- View


type alias View inputs =
    { style : Style
    , field : Field inputs
    }


type Style
    = Large
    | Medium
    | Small
    | TextArea Border


type Border
    = Borderless
    | Bordered



-- Construct


large : Field inputs -> View inputs
large =
    View Large


medium : Field inputs -> View inputs
medium =
    View Medium


small : Field inputs -> View inputs
small =
    View Small


area : Field inputs -> View inputs
area =
    View (TextArea Bordered)


borderless : Field inputs -> View inputs
borderless =
    View (TextArea Borderless)



-- Render


toElement : (inputs -> msg) -> View inputs -> inputs -> Element msg
toElement msg viewConfig inputs =
    let
        field =
            Field.config viewConfig.field

        commonAttributes =
            [ Anchor.description field.label
            , padding Scale.small
            ]

        config_ =
            { onChange = field.update inputs >> msg
            , text = field.value inputs
            , placeholder = Just (placeholder field.label)
            , label = Input.labelHidden field.label
            }
    in
    case viewConfig.style of
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


toAreaStyle : Border -> List (Attribute msg)
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
