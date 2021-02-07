module Api.Object.ProfileMaxFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileMaxFields)
import Data.Maybe (Maybe)

bio :: SelectionSet Scope__ProfileMaxFields (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__ProfileMaxFields (Maybe String)
email = selectionForField "email" [] graphqlDefaultResponseScalarDecoder

profile_image :: SelectionSet Scope__ProfileMaxFields (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__ProfileMaxFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__ProfileMaxFields (Maybe String)
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
