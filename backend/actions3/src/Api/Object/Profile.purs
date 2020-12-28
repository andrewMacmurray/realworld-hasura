module Api.Object.Profile where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , Optional
  , selectionForCompositeField
  , toGraphQLArguments
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__Profile, Scope__Follows)
import Data.Maybe (Maybe)
import Api.Enum.FollowsSelectColumn (FollowsSelectColumn)
import Api.InputObject (FollowsOrderBy, FollowsBoolExp) as Api.InputObject
import Type.Row (type (+))

bio :: SelectionSet Scope__Profile (Maybe String)
bio = selectionForField "bio" [] graphqlDefaultResponseScalarDecoder

email :: SelectionSet Scope__Profile (Maybe String)
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
                                           Scope__Profile
                                           (Array
                                            r)
follows input = selectionForCompositeField
                "follows"
                (toGraphQLArguments
                 input)
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

profile_image :: SelectionSet Scope__Profile (Maybe String)
profile_image = selectionForField
                "profile_image"
                []
                graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__Profile (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder

username :: SelectionSet Scope__Profile (Maybe String)
username = selectionForField "username" [] graphqlDefaultResponseScalarDecoder
