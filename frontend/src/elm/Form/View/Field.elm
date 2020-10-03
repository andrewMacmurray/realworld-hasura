module Form.View.Field exposing
    ( Style
    , View
    , area
    , borderless
    , large
    , medium
    , showErrorsIf
    , small
    , toElement
    , validateWith
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Form.Error as Error
import Form.Field as Field exposing (Field)
import Form.Validation exposing (Validation)



-- View


type alias View inputs output =
    { style : Style
    , validation : Maybe (Validation inputs output)
    , field : Field inputs
    , errorsVisible : Bool
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


large : Field inputs -> View inputs output
large =
    defaults_ Large


medium : Field inputs -> View inputs output
medium =
    defaults_ Medium


small : Field inputs -> View inputs output
small =
    defaults_ Small


area : Field inputs -> View inputs output
area =
    defaults_ (TextArea Bordered)


borderless : Field inputs -> View inputs output
borderless =
    defaults_ (TextArea Borderless)


defaults_ : Style -> Field inputs -> View inputs output
defaults_ style field =
    { style = style
    , validation = Nothing
    , field = field
    , errorsVisible = True
    }



-- Configure


validateWith : Validation inputs output -> View inputs output -> View inputs output
validateWith validation options =
    { options | validation = Just validation }


showErrorsIf : Bool -> View inputs output -> View inputs output
showErrorsIf errorsVisible options =
    { options | errorsVisible = errorsVisible }



-- Render


toElement : (inputs -> msg) -> View inputs output -> inputs -> Element msg
toElement msg ({ field, style, validation } as options) inputs =
    let
        commonAttributes =
            List.concat
                [ [ Anchor.description (Field.label field), padding Scale.small ]
                , errorAttributes options inputs
                ]

        config_ =
            { onChange = Field.update field inputs >> msg
            , text = Field.value field inputs
            , placeholder = Just (placeholder (Field.label field))
            , label = Input.labelHidden (Field.label field)
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


errorAttributes : View inputs output -> inputs -> List (Attribute msg)
errorAttributes { validation, field, errorsVisible } inputs =
    if errorsVisible then
        validation
            |> Maybe.map (Error.attributes field inputs)
            |> Maybe.withDefault []

    else
        []


toAreaStyle : Border -> List (Attribute msg)
toAreaStyle border =
    case border of
        Borderless ->
            [ Border.widthEach { edges | bottom = 2 }
            , paddingXY 3 Scale.small
            , Border.rounded 0
            , Border.color Palette.lightGrey
            ]

        Bordered ->
            [ height (fill |> minimum 150) ]


placeholder : String -> Input.Placeholder msg
placeholder label =
    Input.placeholder [] (Element.text label)
