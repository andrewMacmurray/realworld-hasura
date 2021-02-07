module Api.Object.UsersSumFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersSumFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__UsersSumFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
