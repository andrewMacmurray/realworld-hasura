module Api.Object.Likes where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  )
import Api.Scopes (Scope__Articles, Scope__Likes, Scope__Users)

article :: forall r . SelectionSet
                      Scope__Articles
                      r -> SelectionSet
                           Scope__Likes
                           r
article = selectionForCompositeField
          "article"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

article_id :: SelectionSet Scope__Likes Int
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__Likes Int
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user :: forall r . SelectionSet Scope__Users r -> SelectionSet Scope__Likes r
user = selectionForCompositeField
       "user"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

user_id :: SelectionSet Scope__Likes Int
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
