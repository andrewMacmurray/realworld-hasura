module Animation.Named exposing (fadeIn)

import Animation exposing (Animation)


fadeIn : Float -> List Animation.Option -> Animation
fadeIn =
    Animation.named "fade-in"
