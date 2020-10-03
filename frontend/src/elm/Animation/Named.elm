module Animation.Named exposing
    ( fadeIn
    , fadeOut
    , yoyo
    )

import Animation exposing (Animation)


fadeIn : Float -> List Animation.Option -> Animation
fadeIn =
    Animation.named "fade-in"


fadeOut : Float -> List Animation.Option -> Animation
fadeOut =
    Animation.named "fade-out"


yoyo : Float -> List Animation.Option -> Animation
yoyo =
    Animation.named "yoyo"
