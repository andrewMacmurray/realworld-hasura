module Form.View.Field exposing
    ( FieldType
    , View
    , area
    , borderless
    , currentPassword
    , large
    , medium
    , newPassword
    , showErrorsIf
    , small
    , toElement
    , validateWith
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Form.Error as Error
import Form.Field as Field exposing (Field)
import Form.Validation exposing (Validation)



-- View


type alias View inputs output =
    { fieldType : FieldType
    , validation : Maybe (Validation inputs output)
    , field : Field inputs
    , errorsVisible : Bool
    }


type FieldType
    = TextField Size
    | Password Password
    | TextArea Border


type Password
    = New
    | Current


type Size
    = Small
    | Medium
    | Large


type Border
    = Borderless
    | Bordered



-- Construct


large : Field inputs -> View inputs output
large =
    defaults_ (TextField Large)


medium : Field inputs -> View inputs output
medium =
    defaults_ (TextField Medium)


small : Field inputs -> View inputs output
small =
    defaults_ (TextField Small)


area : Field inputs -> View inputs output
area =
    defaults_ (TextArea Bordered)


borderless : Field inputs -> View inputs output
borderless =
    defaults_ (TextArea Borderless)


newPassword : Field inputs -> View inputs output
newPassword =
    defaults_ (Password New)


currentPassword : Field inputs -> View inputs output
currentPassword =
    defaults_ (Password Current)


defaults_ : FieldType -> Field inputs -> View inputs output
defaults_ style field =
    { fieldType = style
    , validation = Nothing
    , field = field
    , errorsVisible = True
    }



-- Configure


validateWith : Validation inputs output -> View inputs output -> View inputs output
validateWith validation options =
    { options | validation = Just validation }


showErrorsIf : Bool -> View inputs output -> View inputs output
showErrorsIf errorsVisible options =
    { options | errorsVisible = errorsVisible }



-- Render


toElement : (inputs -> msg) -> View inputs output -> inputs -> Element msg
toElement msg options inputs =
    case options.fieldType of
        TextField size ->
            toTextField size options inputs msg

        Password password ->
            toPasswordField password options inputs msg

        TextArea border ->
            toTextAreaField border options inputs msg


toTextAreaField : Border -> View inputs output -> inputs -> (inputs -> msg) -> Element msg
toTextAreaField border options inputs msg =
    let
        config =
            common options inputs msg
    in
    Input.multiline
        (List.concat
            [ [ Font.size Text.small ]
            , attributes options inputs
            , toAreaStyle border
            ]
        )
        { onChange = config.onChange
        , text = config.text
        , placeholder = config.placeholder
        , label = config.label
        , spellcheck = True
        }


toPasswordField : Password -> View inputs output -> inputs -> (inputs -> msg) -> Element msg
toPasswordField password options input msg =
    let
        common_ =
            common options input msg

        attributes_ =
            fontSize Medium :: attributes options input

        config =
            { onChange = common_.onChange
            , text = common_.text
            , placeholder = common_.placeholder
            , label = common_.label
            , show = False
            }
    in
    case password of
        New ->
            Input.newPassword attributes_ config

        Current ->
            Input.currentPassword attributes_ config


toTextField : Size -> View inputs output -> inputs -> (inputs -> msg) -> Element msg
toTextField size options input msg =
    Input.text
        (fontSize size :: attributes options input)
        (common options input msg)


fontSize : Size -> Attr decorative msg
fontSize size =
    case size of
        Small ->
            Font.size Text.small

        Medium ->
            Font.size Text.medium

        Large ->
            Font.size Text.large


type alias Common msg =
    { onChange : String -> msg
    , text : String
    , placeholder : Maybe (Input.Placeholder msg)
    , label : Input.Label msg
    }


common : View inputs output -> inputs -> (inputs -> msg) -> Common msg
common options inputs msg =
    { onChange = Field.update options.field inputs >> msg
    , text = Field.value options.field inputs
    , placeholder = Just (placeholder (Field.label options.field))
    , label = Input.labelHidden (Field.label options.field)
    }


attributes : View inputs output -> inputs -> List (Attribute msg)
attributes options inputs =
    List.concat
        [ [ Anchor.description (Field.label options.field), padding Scale.small ]
        , errorAttributes options inputs
        ]


errorAttributes : View inputs output -> inputs -> List (Attribute msg)
errorAttributes { validation, field, errorsVisible } inputs =
    if errorsVisible then
        validation
            |> Maybe.map (Error.attributes field inputs)
            |> Maybe.withDefault []

    else
        []


toAreaStyle : Border -> List (Attribute msg)
toAreaStyle border =
    case border of
        Borderless ->
            [ Border.widthEach { edges | bottom = 2 }
            , paddingXY 3 Scale.small
            , Border.rounded 0
            , Border.color Palette.lightGrey
            ]

        Bordered ->
            [ height (fill |> minimum 150) ]


placeholder : String -> Input.Placeholder msg
placeholder label =
    Input.placeholder [] (Element.text label)
