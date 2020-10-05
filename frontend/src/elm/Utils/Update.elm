module Utils.Update exposing
    ( updateWith
    , withCmd
    , withEffect
    )

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


withCmd : Cmd msg -> ( model, Cmd msg ) -> ( model, Cmd msg )
withCmd cmd2 ( model, cmd1 ) =
    ( model, Cmd.batch [ cmd1, cmd2 ] )


withEffect : Effect msg -> ( model, Effect msg ) -> ( model, Effect msg )
withEffect eff2 ( model, eff1 ) =
    ( model, Effect.batch [ eff1, eff2 ] )
