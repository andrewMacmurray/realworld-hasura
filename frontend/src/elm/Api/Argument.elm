module Api.Argument exposing
    ( author
    , combine2
    , combine4
    , created_at
    , eq_
    , field
    , following_id
    , id
    , in_
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


order_by =
    field (\val args -> { args | order_by = Present [ val ] })


created_at =
    prop (\val args -> { args | created_at = Present val })


eq_ =
    prop (\val args -> { args | eq_ = Present val })


following_id =
    field (\val args -> { args | following_id = Present val })


tag =
    field (\val args -> { args | tag = Present val })


tags =
    field (\val args -> { args | tags = Present val })


author =
    field (\val args -> { args | author = Present val })


id =
    field (\val args -> { args | id = Present val })


in_ =
    prop (\val args -> { args | in_ = Present val })


where_ =
    field (\val args -> { args | where_ = Present val })
