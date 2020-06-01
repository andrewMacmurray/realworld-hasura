module Api.Argument exposing
    ( combine2
    , combine4
    , created_at
    , eq_
    , field
    , order_by
    , prop
    , tag
    , tags
    , where_
    )

import Graphql.OptionalArgument exposing (OptionalArgument(..))



-- Helpers for combining Nested Graphql Argument Queries


type alias Field a b =
    { field : a
    , expression : b
    }


type alias Prop a b =
    { field : a
    , value : b
    }



-- Combine


combine2 : Field (input -> output) (c -> input) -> Prop (d -> c) d -> output
combine2 a b =
    a.field (a.expression (b.field b.value))


combine4 : Field (a -> b) (c -> a) -> Field (d -> c) (e -> d) -> Field (f -> e) (j -> f) -> Prop (k -> j) k -> b
combine4 a b c d =
    a.field (a.expression (b.field (b.expression (c.field (c.expression (d.field d.value))))))



-- Field


field : field -> expr -> Field field expr
field a b =
    { field = a
    , expression = b
    }



-- Prop


prop : field -> value -> Prop field value
prop a b =
    { field = a
    , value = b
    }



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
