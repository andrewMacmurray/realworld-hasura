module Api.Object.Users where

import GraphQLClient
  ( Optional
  , SelectionSet
  , selectionForCompositeField
  , toGraphQLArguments
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  )
import Api.Enum.ArticlesSelectColumn (ArticlesSelectColumn)
import Api.InputObject
  (ArticlesOrderBy, ArticlesBoolExp, FollowsOrderBy, FollowsBoolExp) as Api.InputObject
import Type.Row (type (+))
import Api.Scopes
  ( Scope__Articles
  , Scope__Users
  , Scope__ArticlesAggregate
  , Scope__Follows
  , Scope__FollowsAggregate
  )
import Data.Maybe (Maybe)
import Api.Enum.FollowsSelectColumn (FollowsSelectColumn)

type ArticlesInputRowOptional r = ( distinct_on :: Optional
                                                   (Array
                                                    ArticlesSelectColumn)
                                  , limit :: Optional Int
                                  , offset :: Optional Int
                                  , order_by :: Optional
                                                (Array
                                                 Api.InputObject.ArticlesOrderBy)
                                  , "where" :: Optional
                                               Api.InputObject.ArticlesBoolExp
                                  | r
                                  )

type ArticlesInput = { | ArticlesInputRowOptional + () }

articles :: forall r . ArticlesInput -> SelectionSet
                                        Scope__Articles
                                        r -> SelectionSet
                                             Scope__Users
                                             (Array
                                              r)
articles input = selectionForCompositeField
                 "articles"
                 (toGraphQLArguments
                  input)
                 graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type ArticlesAggregateInputRowOptional r = ( distinct_on :: Optional
                                                            (Array
                                                             ArticlesSelectColumn)
                                           , limit :: Optional Int
                                           , offset :: Optional Int
                                           , order_by :: Optional
                                                         (Array
                                                          Api.InputObject.ArticlesOrderBy)
                                           , "where" :: Optional
                                                        Api.InputObject.ArticlesBoolExp
                                           | r
                                           )

type ArticlesAggregateInput = { | ArticlesAggregateInputRowOptional + () }

articles_aggregate :: forall r . ArticlesAggregateInput -> SelectionSet
                                                           Scope__ArticlesAggregate
                                                           r -> SelectionSet
                                                                Scope__Users
                                                                r
articles_aggregate input = selectionForCompositeField
                           "articles_aggregate"
                           (toGraphQLArguments
                            input)
                           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

bio :: SelectionSet Scope__Users (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__Users String
email = selectionForField "email" [] graphqlDefaultResponseScalarDecoder

type FollowsInputRowOptional r = ( distinct_on :: Optional
                                                  (Array
                                                   FollowsSelectColumn)
                                 , limit :: Optional Int
                                 , offset :: Optional Int
                                 , order_by :: Optional
                                               (Array
                                                Api.InputObject.FollowsOrderBy)
                                 , "where" :: Optional
                                              Api.InputObject.FollowsBoolExp
                                 | r
                                 )

type FollowsInput = { | FollowsInputRowOptional + () }

follows :: forall r . FollowsInput -> SelectionSet
                                      Scope__Follows
                                      r -> SelectionSet
                                           Scope__Users
                                           (Array
                                            r)
follows input = selectionForCompositeField
                "follows"
                (toGraphQLArguments
                 input)
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type FollowsAggregateInputRowOptional r = ( distinct_on :: Optional
                                                           (Array
                                                            FollowsSelectColumn)
                                          , limit :: Optional Int
                                          , offset :: Optional Int
                                          , order_by :: Optional
                                                        (Array
                                                         Api.InputObject.FollowsOrderBy)
                                          , "where" :: Optional
                                                       Api.InputObject.FollowsBoolExp
                                          | r
                                          )

type FollowsAggregateInput = { | FollowsAggregateInputRowOptional + () }

follows_aggregate :: forall r . FollowsAggregateInput -> SelectionSet
                                                         Scope__FollowsAggregate
                                                         r -> SelectionSet
                                                              Scope__Users
                                                              r
follows_aggregate input = selectionForCompositeField
                          "follows_aggregate"
                          (toGraphQLArguments
                           input)
                          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

id :: SelectionSet Scope__Users Int
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

password_hash :: SelectionSet Scope__Users String
password_hash = selectionForField
                "password_hash"
                []
                graphqlDefaultResponseScalarDecoder

profile_image :: SelectionSet Scope__Users (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__Users String
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
