module Api.Object.ProfileMinFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileMinFields)
import Data.Maybe (Maybe)

bio :: SelectionSet Scope__ProfileMinFields (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__ProfileMinFields (Maybe String)
email = selectionForField "email" [] graphqlDefaultResponseScalarDecoder

profile_image :: SelectionSet Scope__ProfileMinFields (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__ProfileMinFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__ProfileMinFields (Maybe String)
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
