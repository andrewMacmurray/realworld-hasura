module Form.Error exposing (attributes)

import Element exposing (Attribute)
import Element.Anchor as Anchor
import Element.Border as Border
import Element.Palette as Palette
import Form.Field as Field exposing (Field)
import Form.Validation as Validation exposing (Validation)


attributes : Field inputs -> inputs -> Validation inputs output -> List (Attribute msg)
attributes field inputs validation =
    if hasError field inputs validation then
        [ Border.color Palette.red
        , Anchor.description (Field.label field ++ "-error")
        ]

    else
        []


hasError : Field inputs -> inputs -> Validation inputs output -> Bool
hasError field inputs =
    Validation.run inputs >> Validation.hasErrorFor (Field.id field)
