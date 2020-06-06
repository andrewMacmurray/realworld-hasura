module Utils.SelectionSet exposing (failOnNothing)

import Graphql.SelectionSet as SelectionSet


failOnNothing : SelectionSet.SelectionSet (Maybe a) typeLock -> SelectionSet.SelectionSet a typeLock
failOnNothing =
    SelectionSet.mapOrFail (Result.fromMaybe "required")
