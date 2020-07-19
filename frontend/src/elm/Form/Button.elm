module Form.Button exposing
    ( validateOnInput
    , validateOnSubmit
    )

import Element exposing (Element)
import Element.Button as Button
import Form.Validation as Validation exposing (Validation)



-- Validate On Input


type alias ValidateOnInputOptions inputs output msg =
    { validation : Validation inputs output
    , label : String
    , onSubmit : output -> msg
    , inputs : inputs
    }


validateOnInput : ValidateOnInputOptions inputs output msg -> Element msg
validateOnInput { validation, label, onSubmit, inputs } =
    case Validation.run inputs validation of
        Validation.Success output ->
            Button.button (onSubmit output) label
                |> Button.description label
                |> Button.toElement

        Validation.Failure _ ->
            Button.disabled label
                |> Button.toElement



-- Validate On Submit


type alias ValidateOnSubmitOptions inputs output msg =
    { label : String
    , validation : Validation inputs output
    , inputs : inputs
    , showError : Bool
    , onSubmit : output -> msg
    , onError : msg
    }


validateOnSubmit : ValidateOnSubmitOptions inputs output msg -> Element msg
validateOnSubmit { inputs, validation, onSubmit, label, showError, onError } =
    case Validation.run inputs validation of
        Validation.Success output ->
            Button.button (onSubmit output) label
                |> Button.description label
                |> Button.toElement

        Validation.Failure _ ->
            if showError then
                Button.disabled label
                    |> Button.toElement

            else
                Button.button onError label
                    |> Button.description label
                    |> Button.toElement
