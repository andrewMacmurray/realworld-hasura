module Form.Button exposing
    ( validateOnInput
    , validateOnSubmit
    )

import Element exposing (Element)
import Element.Button as Button exposing (Button)
import Form.Validation as Validation exposing (Validation)



-- Validate On Input


type alias ValidateOnInputOptions inputs output msg =
    { validation : Validation inputs output
    , label : String
    , style : Button msg -> Button msg
    , onSubmit : output -> msg
    , inputs : inputs
    }


validateOnInput : ValidateOnInputOptions inputs output msg -> Element msg
validateOnInput { validation, label, style, onSubmit, inputs } =
    case Validation.run inputs validation of
        Validation.Success output ->
            Button.button (onSubmit output) label
                |> Button.description label
                |> style
                |> Button.toElement

        Validation.Failure _ ->
            Button.disabled label
                |> style
                |> Button.toElement



-- Validate On Submit


type alias ValidateOnSubmitOptions inputs output msg =
    { label : String
    , validation : Validation inputs output
    , style : Button msg -> Button msg
    , inputs : inputs
    , onSubmit : output -> msg
    , onError : inputs -> msg
    }


validateOnSubmit : ValidateOnSubmitOptions { inputs | errorsVisible : Bool } output msg -> Element msg
validateOnSubmit { inputs, style, validation, onSubmit, label, onError } =
    case Validation.run inputs validation of
        Validation.Success output ->
            Button.button (onSubmit output) label
                |> Button.description label
                |> style
                |> Button.toElement

        Validation.Failure _ ->
            if inputs.errorsVisible then
                Button.disabled label
                    |> style
                    |> Button.toElement

            else
                Button.button (onError { inputs | errorsVisible = True }) label
                    |> Button.description label
                    |> style
                    |> Button.toElement
