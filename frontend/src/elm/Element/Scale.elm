module Element.Scale exposing
    ( edges
    , extraLarge
    , extraSmall
    , large
    , medium
    , small
    )


extraSmall : number
extraSmall =
    8


small : number
small =
    14


medium : number
medium =
    24


large : number
large =
    32


extraLarge : number
extraLarge =
    64


edges : { top : number, right : number, bottom : number, left : number }
edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }
