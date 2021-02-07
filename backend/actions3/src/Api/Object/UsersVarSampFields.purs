module Api.Object.UsersVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersVarSampFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersVarSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
