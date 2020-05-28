module Form.Field exposing (Config, text)

import Element exposing (Element)
import Element.Anchor as Anchor
import Element.Input as Input


type alias Config inputs =
    { value : inputs -> String
    , update : inputs -> String -> inputs
    , label : String
    }


text : (inputs -> msg) -> Config inputs -> inputs -> Element msg
text msg config inputs =
    Input.text [ Anchor.description config.label ]
        { onChange = config.update inputs >> msg
        , text = config.value inputs
        , placeholder = Just (Input.placeholder [] (Element.text config.label))
        , label = Input.labelHidden config.label
        }
