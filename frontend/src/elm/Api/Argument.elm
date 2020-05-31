module Api.Argument exposing
    ( created_at
    , eq_
    , order_by
    , tag
    , tags
    , where_
    )

import Graphql.OptionalArgument exposing (OptionalArgument(..))



-- Helpers for building Graphql Optional Arguments


order_by val args_ =
    { args_ | order_by = Present [ val ] }


created_at val args =
    { args | created_at = Present val }


eq_ val args =
    { args | eq_ = Present val }


tag val args =
    { args | tag = Present val }


tags val args =
    { args | tags = Present val }


where_ val args =
    { args | where_ = Present val }
