module Api.Date exposing (fromScalar)

import Date exposing (Date)
import Graphql.SelectionSet as SelectionSet
import Hasura.Scalar exposing (Timestamptz(..))
import Iso8601
import Time exposing (utc)


fromScalar : SelectionSet.SelectionSet Timestamptz typeLock -> SelectionSet.SelectionSet Date typeLock
fromScalar =
    SelectionSet.mapOrFail fromTimestamp_


fromTimestamp_ : Timestamptz -> Result String Date
fromTimestamp_ (Timestamptz str) =
    Iso8601.toTime str
        |> Result.map (Date.fromPosix utc)
        |> Result.mapError (always "error decoding date")
