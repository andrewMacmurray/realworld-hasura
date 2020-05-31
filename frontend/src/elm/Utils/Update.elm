module Utils.Update exposing (updateWith)

import Effect exposing (Effect)


updateWith :
    (subModel -> model)
    -> (subMsg -> msg)
    -> ( subModel, Effect subMsg )
    -> ( model, Effect msg )
updateWith modelF msgF ( model, eff ) =
    ( modelF model
    , Effect.map msgF eff
    )
