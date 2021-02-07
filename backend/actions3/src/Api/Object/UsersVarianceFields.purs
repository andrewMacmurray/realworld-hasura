module Api.Object.UsersVarianceFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersVarianceFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersVarianceFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
