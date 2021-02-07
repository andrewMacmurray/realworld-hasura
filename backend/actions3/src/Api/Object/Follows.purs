module Api.Object.Follows where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__Follows, Scope__Users)

following_id :: SelectionSet Scope__Follows Int
following_id = selectionForField
               "following_id"
               []
               graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__Follows Int
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user :: forall r . SelectionSet Scope__Users r -> SelectionSet Scope__Follows r
user = selectionForCompositeField
       "user"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

user_id :: SelectionSet Scope__Follows Int
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
