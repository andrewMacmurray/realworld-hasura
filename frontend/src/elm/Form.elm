module Form exposing
    ( Options
    , button
    )

import Element exposing (Element)
import Element.Button as Button
import Form.Validation as Validation exposing (Validation)


type alias Options inputs output msg =
    { validation : Validation inputs output
    , label : String
    , onSubmit : output -> msg
    , inputs : inputs
    }


button : Options inputs output msg -> Element msg
button { validation, label, onSubmit, inputs } =
    case Validation.run inputs validation of
        Validation.Success output ->
            Button.button (onSubmit output) label
                |> Button.description label
                |> Button.toElement

        Validation.Failure _ ->
            Button.disabled label
                |> Button.toElement
