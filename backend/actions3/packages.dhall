let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20201021/packages.dhall sha256:55ebdbda1bd6ede4d5307fbc1ef19988c80271b4225d833c8d6fb9b6fb1aa6d8

let other =
  { ps-cst =
    { dependencies =
      [ "console"
      , "effect"
      , "generics-rep"
      , "psci-support"
      , "record"
      , "strings"
      , "spec"
      , "node-path"
      , "node-fs-aff"
      , "ansi"
      , "dodo-printer"
      ]
    , repo = "https://github.com/purescript-codegen/purescript-ps-cst.git"
    , version = "master"
    }
  , dodo-printer =
    { dependencies =
      [ "aff"
      , "ansi"
      , "avar"
      , "console"
      , "effect"
      , "foldable-traversable"
      , "lists"
      , "maybe"
      , "minibench"
      , "node-child-process"
      , "node-fs-aff"
      , "node-process"
      , "psci-support"
      , "strings"
      ]
    , repo = "https://github.com/natefaubion/purescript-dodo-printer.git"
    , version = "master"
    }
  , unordered-collection =
    { dependencies =
      [ "enums"
      , "functions"
      , "integers"
      , "lists"
      , "prelude"
      , "record"
      , "tuples"
      , "typelevel-prelude"
      ]
    , repo =
        "https://github.com/fehrenbach/purescript-unordered-collections.git"
    , version = "master"
    }
  , homogeneous-records =
    { dependencies =
      [ "record", "prelude", "typelevel-prelude", "unfoldable", "control" ]
    , repo = "https://github.com/srghma/purescript-homogeneous-records.git"
    , version = "master"
    }
  , mkdirp-aff =
    { dependencies =
      [ "prelude"
      , "effect"
      , "node-fs-aff"
      , "node-fs"
      , "node-path"
      , "either"
      , "exceptions"
      , "aff"
      ]
    , repo = "https://github.com/leighman/purescript-mkdirp-aff.git"
    , version = "master"
    }
  , url-regex-safe =
    { dependencies =
      [ "console"
      , "effect"
      , "psci-support"
      , "strings"
      ]
    , repo = "https://github.com/srghma/purescript-url-regex-safe.git"
    , version = "master"
    }
  , graphql-client =
    { dependencies =
        [ "affjax"
        , "effect"
        , "generics-rep"
        , "node-fs-aff"
        , "prelude"
        , "proxy"
        , "psci-support"
        , "record"
        , "argonaut-core"
        , "argonaut-codecs"
        , "argonaut-generic"
        , "typelevel-prelude"
        , "debug"
        , "spec"
        , "variant"
        , "unordered-collections"
        , "web-socket"
        ]
    , repo = "https://github.com/purescript-graphql-client/purescript-graphql-client.git"
    , version = "fad4a2881153975870ef349a707c0b331f958572"
    }
  }

in (    upstream
    //  other
   )
  with affjax.version = "v11.0.0"