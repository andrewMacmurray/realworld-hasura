module Api.Object.Comments where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  )
import Api.Scopes (Scope__Articles, Scope__Comments, Scope__Users)
import Api.Scalars (Timestamptz)

article :: forall r . SelectionSet
                      Scope__Articles
                      r -> SelectionSet
                           Scope__Comments
                           r
article = selectionForCompositeField
          "article"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

article_id :: SelectionSet Scope__Comments Int
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

comment :: SelectionSet Scope__Comments String
comment = selectionForField "comment" [] graphqlDefaultResponseScalarDecoder

created_at :: SelectionSet Scope__Comments Timestamptz
created_at = selectionForField
             "created_at"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__Comments Int
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user :: forall r . SelectionSet Scope__Users r -> SelectionSet Scope__Comments r
user = selectionForCompositeField
       "user"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

user_id :: SelectionSet Scope__Comments Int
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
