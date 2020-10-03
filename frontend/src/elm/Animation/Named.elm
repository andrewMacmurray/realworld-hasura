module Animation.Named exposing
    ( fadeIn
    , yoyo
    )

import Animation exposing (Animation)


fadeIn : Float -> List Animation.Option -> Animation
fadeIn =
    Animation.named "fade-in"


yoyo : Float -> List Animation.Option -> Animation
yoyo =
    Animation.named "yoyo"
