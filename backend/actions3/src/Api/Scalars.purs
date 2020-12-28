module Api.Scalars where

import Data.Newtype (class Newtype)
import Prelude (class Eq, class Ord, class Show)
import GraphQLClient
  (class GraphQLDefaultResponseScalarDecoder, class ToGraphQLArgumentValue)

-- | original name - ID
newtype Id = Id String

derive instance newtypeId :: Newtype Id _

derive newtype instance eqId :: Eq Id

derive newtype instance ordId :: Ord Id

derive newtype instance showId :: Show Id

derive newtype instance graphQlDefaultResponseScalarDecoderId :: GraphQLDefaultResponseScalarDecoder Id

derive newtype instance toGraphQlArgumentValueId :: ToGraphQLArgumentValue Id

-- | original name - json
newtype Json = Json String

derive instance newtypeJson :: Newtype Json _

derive newtype instance eqJson :: Eq Json

derive newtype instance ordJson :: Ord Json

derive newtype instance showJson :: Show Json

derive newtype instance graphQlDefaultResponseScalarDecoderJson :: GraphQLDefaultResponseScalarDecoder Json

derive newtype instance toGraphQlArgumentValueJson :: ToGraphQLArgumentValue Json

-- | original name - timestamptz
newtype Timestamptz = Timestamptz String

derive instance newtypeTimestamptz :: Newtype Timestamptz _

derive newtype instance eqTimestamptz :: Eq Timestamptz

derive newtype instance ordTimestamptz :: Ord Timestamptz

derive newtype instance showTimestamptz :: Show Timestamptz

derive newtype instance graphQlDefaultResponseScalarDecoderTimestamptz :: GraphQLDefaultResponseScalarDecoder Timestamptz

derive newtype instance toGraphQlArgumentValueTimestamptz :: ToGraphQLArgumentValue Timestamptz

-- | original name - uuid
newtype Uuid = Uuid String

derive instance newtypeUuid :: Newtype Uuid _

derive newtype instance eqUuid :: Eq Uuid

derive newtype instance ordUuid :: Ord Uuid

derive newtype instance showUuid :: Show Uuid

derive newtype instance graphQlDefaultResponseScalarDecoderUuid :: GraphQLDefaultResponseScalarDecoder Uuid

derive newtype instance toGraphQlArgumentValueUuid :: ToGraphQLArgumentValue Uuid
