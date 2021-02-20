{ name = "my-project"
, dependencies =
  [ "console"
  , "effect"
  , "graphql-client"
  , "nullable"
  , "payload"
  , "prelude"
  , "psci-support"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
