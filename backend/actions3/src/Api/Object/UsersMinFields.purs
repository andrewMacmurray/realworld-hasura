module Api.Object.UsersMinFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__UsersMinFields)
import Data.Maybe (Maybe)

bio :: SelectionSet Scope__UsersMinFields (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__UsersMinFields (Maybe String)
email = selectionForField "email" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__UsersMinFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

password_hash :: SelectionSet Scope__UsersMinFields (Maybe String)
password_hash = selectionForField
                "password_hash"
                []
                graphqlDefaultResponseScalarDecoder

profile_image :: SelectionSet Scope__UsersMinFields (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__UsersMinFields (Maybe String)
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
