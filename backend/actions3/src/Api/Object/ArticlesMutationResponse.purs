module Api.Object.ArticlesMutationResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__ArticlesMutationResponse, Scope__Articles)

affected_rows :: SelectionSet Scope__ArticlesMutationResponse Int
affected_rows = selectionForField
                "affected_rows"
                []
                graphqlDefaultResponseScalarDecoder

returning :: forall r . SelectionSet
                        Scope__Articles
                        r -> SelectionSet
                             Scope__ArticlesMutationResponse
                             (Array
                              r)
returning = selectionForCompositeField
            "returning"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer
