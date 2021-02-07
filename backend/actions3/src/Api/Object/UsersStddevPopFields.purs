module Api.Object.UsersStddevPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersStddevPopFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersStddevPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
