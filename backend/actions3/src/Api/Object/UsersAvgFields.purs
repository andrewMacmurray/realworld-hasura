module Api.Object.UsersAvgFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersAvgFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersAvgFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
