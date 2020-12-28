module Api.Object.TokenResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__TokenResponse, Scope__Follows)
import Data.Maybe (Maybe)

bio :: SelectionSet Scope__TokenResponse (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__TokenResponse String
email = selectionForField "email" [] graphqlDefaultResponseScalarDecoder

follows :: forall r . SelectionSet
                      Scope__Follows
                      r -> SelectionSet
                           Scope__TokenResponse
                           (Maybe
                            (Array
                             (Maybe
                              r)))
follows = selectionForCompositeField
          "follows"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

profile_image :: SelectionSet Scope__TokenResponse (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

token :: SelectionSet Scope__TokenResponse String
token = selectionForField "token" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__TokenResponse Int
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__TokenResponse String
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
