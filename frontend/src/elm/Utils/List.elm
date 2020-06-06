module Utils.List exposing (remove)


remove : a -> List a -> List a
remove a =
    List.filter (\x -> x /= a)
