module Utils.Update exposing (updateWith)

import Effect


updateWith modelF msgF ( model, eff ) =
    ( modelF model
    , Effect.map msgF eff
    )
