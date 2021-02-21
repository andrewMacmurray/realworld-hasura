{ name = "realworld-actions"
, dependencies =
  [ "console"
  , "effect"
  , "nullable"
  , "payload"
  , "prelude"
  , "psci-support"
  , "simple-ajax"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
