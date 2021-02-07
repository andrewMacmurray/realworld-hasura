module Api.Object.UsersStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersStddevSampFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersStddevSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
