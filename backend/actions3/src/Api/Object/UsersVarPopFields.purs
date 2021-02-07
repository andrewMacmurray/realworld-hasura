module Api.Object.UsersVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersVarPopFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersVarPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
