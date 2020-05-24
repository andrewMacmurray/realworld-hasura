module Element.Text exposing
    ( link
    , subtitle
    , title
    )

import Element
import Element.Font as Font
import Element.Palette as Palette


title : List (Element.Attribute msg) -> String -> Element.Element msg
title attrs content =
    Element.el
        (List.concat
            [ [ Font.size large
              , Font.color Palette.black
              ]
            , attrs
            ]
        )
        (Element.text content)


subtitle : List (Element.Attribute msg) -> String -> Element.Element msg
subtitle attrs content =
    Element.el
        (List.concat
            [ [ Font.size medium
              , Font.color Palette.green
              , Font.bold
              ]
            , attrs
            ]
        )
        (Element.text content)


link : List (Element.Attribute msg) -> String -> Element.Element msg
link attrs content =
    Element.el
        (List.concat
            [ [ Font.size small
              , Element.pointer
              , Font.color Palette.grey
              , Element.mouseOver [ Font.color Palette.black ]
              ]
            , attrs
            ]
        )
        (Element.text content)


large =
    32


medium : number
medium =
    22


small : number
small =
    14
