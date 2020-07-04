module Form.Field exposing
    ( Config
    , Field
    , config
    , field
    )

-- Field Config


type Field inputs
    = Field (Config inputs)


type alias Config inputs =
    { value : inputs -> String
    , update : inputs -> String -> inputs
    , label : String
    }



-- Construct


field : Config inputs -> Field inputs
field =
    Field


config : Field inputs -> Config inputs
config (Field config_) =
    config_
