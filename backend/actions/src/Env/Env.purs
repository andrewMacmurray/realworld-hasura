module Env
  ( adminSecret
  , graphqlUrl
  , actionsSecret
  ) where

foreign import adminSecret :: String

foreign import graphqlUrl :: String

foreign import actionsSecret :: String
