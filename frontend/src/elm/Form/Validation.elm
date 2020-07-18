module Form.Validation exposing
    ( Errors
    , Result(..)
    , Validation
    , build
    , constant
    , hasErrorFor
    , map
    , nonEmpty
    , optional
    , run
    )

import Form.Field as Field exposing (Field)
import Set exposing (Set)
import Utils.String as String



-- Validation


type Validation inputs output
    = Validation (inputs -> Result output)


type Result output
    = Success output
    | Failure Errors



-- Errors


type Errors
    = Errors (Set FieldId)


type alias FieldId =
    String



-- Build


build : output -> Validation inputs output
build output_ =
    Validation (\_ -> Success output_)



-- Transform


map : (outputA -> outputB) -> Validation inputs outputA -> Validation inputs outputB
map f (Validation toOutput) =
    Validation
        (\inputs_ ->
            case toOutput inputs_ of
                Success output_ ->
                    Success (f output_)

                Failure errs ->
                    Failure errs
        )



-- Fields


constant : a -> Validation inputs (a -> output) -> Validation inputs output
constant val (Validation toOutput) =
    Validation
        (\inputs ->
            case toOutput inputs of
                Success toOutput_ ->
                    Success (toOutput_ val)

                Failure err ->
                    Failure err
        )


nonEmpty : Field inputs -> Validation inputs (String.NonEmpty -> output) -> Validation inputs output
nonEmpty field (Validation toOutput) =
    Validation
        (\inputs_ ->
            let
                result =
                    toOutput inputs_
            in
            case String.toNonEmpty (Field.value field inputs_) of
                Just value ->
                    case result of
                        Success toOutput_ ->
                            Success (toOutput_ value)

                        Failure err ->
                            Failure err

                Nothing ->
                    addToErrors (Field.id field) result
        )


optional : Field inputs -> Validation inputs (String.Optional -> output) -> Validation inputs output
optional field (Validation toOutput) =
    Validation
        (\inputs_ ->
            let
                value =
                    String.toOptional (Field.value field inputs_)
            in
            case toOutput inputs_ of
                Success toOutput_ ->
                    Success (toOutput_ value)

                Failure err ->
                    Failure err
        )



-- Run Validation


run : inputs -> Validation inputs output -> Result output
run inputs (Validation toOutput) =
    toOutput inputs



-- Errors


addToErrors : FieldId -> Result a -> Result b
addToErrors id res =
    case res of
        Success _ ->
            Failure (Errors (Set.singleton id))

        Failure (Errors errors) ->
            Failure (Errors (Set.insert id errors))


hasErrorFor : FieldId -> Result output -> Bool
hasErrorFor id errors =
    case errors of
        Failure (Errors errs_) ->
            Set.member id errs_

        Success _ ->
            False
