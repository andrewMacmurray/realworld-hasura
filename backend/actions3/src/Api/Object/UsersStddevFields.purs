module Api.Object.UsersStddevFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersStddevFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersStddevFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
