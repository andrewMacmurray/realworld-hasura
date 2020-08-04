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


constant : value -> Validation inputs (value -> output) -> Validation inputs output
constant value =
    map (\toOutput -> toOutput value)


nonEmpty : Field inputs -> Validation inputs (String.NonEmpty -> output) -> Validation inputs output
nonEmpty field (Validation toOutput) =
    Validation
        (\inputs_ ->
            Field.value field inputs_
                |> String.toNonEmpty
                |> Maybe.map (mapResult (toOutput inputs_))
                |> Maybe.withDefault (addToErrors (Field.id field) (toOutput inputs_))
        )


optional : Field inputs -> Validation inputs (String.Optional -> output) -> Validation inputs output
optional field (Validation toOutput) =
    Validation
        (\inputs_ ->
            Field.value field inputs_
                |> String.toOptional
                |> mapResult (toOutput inputs_)
        )


mapResult : Result (value -> output) -> value -> Result output
mapResult result value =
    case result of
        Success toOutput ->
            Success (toOutput value)

        Failure err ->
            Failure err



-- Run


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
