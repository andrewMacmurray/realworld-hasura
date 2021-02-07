module Api.Object.UsersMaxFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersMaxFields)
import Data.Maybe (Maybe)

bio :: SelectionSet Scope__UsersMaxFields (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__UsersMaxFields (Maybe String)
email = selectionForField "email" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__UsersMaxFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

password_hash :: SelectionSet Scope__UsersMaxFields (Maybe String)
password_hash = selectionForField
                "password_hash"
                []
                graphqlDefaultResponseScalarDecoder

profile_image :: SelectionSet Scope__UsersMaxFields (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__UsersMaxFields (Maybe String)
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
