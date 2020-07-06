module Form.Field exposing
    ( Config
    , Field
    , field
    , id
    , label
    , update
    , value
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



-- Query


id : Field inputs -> String
id =
    config >> .label


label : Field inputs -> String
label =
    config >> .label


value : Field inputs -> inputs -> String
value =
    config >> .value


update : Field inputs -> inputs -> String -> inputs
update =
    config >> .update



-- Helpers


config : Field inputs -> Config inputs
config (Field config_) =
    config_
