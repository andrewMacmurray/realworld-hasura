module Main where

import Prelude
import Api.Object.Articles as Articles
import Api.Object.Users as User
import Api.Query as Query
import Api.Scopes (Scope__Articles)
import Data.Either (Either(..))
import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (logShow)
import Effect.Console (log)
import GraphQLClient (GraphQLError, Scope__RootQuery, SelectionSet, defaultInput, defaultRequestOptions, graphqlQueryRequest)

query :: SelectionSet Scope__RootQuery (Array Article)
query =
  Query.articles defaultInput
    ( { id: _, about: _, title: _, author: _ }
        <$> Articles.id
        <*> Articles.about
        <*> Articles.title
        <*> authorSelection
    )

authorSelection :: SelectionSet Scope__Articles Author
authorSelection =
  Articles.author
    ( { id: _, username: _, profileImage: _ }
        <$> User.id
        <*> User.username
        <*> User.profile_image
    )

type Response
  = Array Article

type Article
  = { id :: Int
    , about :: String
    , title :: String
    , author :: Author
    }

type Author
  = { id :: Int
    , username :: String
    , profileImage :: Maybe String
    }

main :: Effect Unit
main =
  launchAff_
    $ do
        res :: ApiResponse Response <- hasuraRequest query
        liftEffect
          ( case res of
              Right x -> logShow x
              Left err -> log "something went wrong :("
          )

type ApiResponse decoded
  = Either (GraphQLError decoded) decoded

hasuraRequest :: forall decoded. SelectionSet Scope__RootQuery decoded -> Aff (ApiResponse decoded)
hasuraRequest = graphqlQueryRequest "http://localhost:8080/v1/graphql" defaultRequestOptions
