module Form.Field exposing
    ( Config
    , Style
    , area
    , large
    , medium
    , small
    , text
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Font as Font
import Element.Input as Input
import Element.Scale as Scale
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
    | TextArea


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
    TextArea


text : (inputs -> msg) -> Style -> Config inputs -> inputs -> Element msg
text msg style config inputs =
    let
        description =
            Anchor.description config.label

        config_ =
            { onChange = config.update inputs >> msg
            , text = config.value inputs
            , placeholder = Just (placeholder config.label)
            , label = Input.labelHidden config.label
            }
    in
    case style of
        Small ->
            Input.text [ description, padding Scale.small, Font.size Text.small ] config_

        Medium ->
            Input.text [ description, padding Scale.small, Font.size Text.medium ] config_

        Large ->
            Input.text [ description, padding Scale.medium, Font.size Text.medium ] config_

        TextArea ->
            Input.multiline
                [ description
                , padding Scale.small
                , Font.size Text.small
                , height (fill |> minimum 150)
                ]
                { onChange = config_.onChange
                , text = config_.text
                , placeholder = config_.placeholder
                , label = config_.label
                , spellcheck = True
                }


placeholder : String -> Input.Placeholder msg
placeholder label =
    Input.placeholder [] (Element.text label)
