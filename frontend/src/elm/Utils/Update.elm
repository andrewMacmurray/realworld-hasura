module Utils.Update exposing
    ( updateWith
    , withCmd
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
