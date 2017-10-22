module Main exposing (..)

import Html exposing (Html, text, div, img, button, input, Attribute)
import Html.Attributes exposing (src, value)
import Html.Events exposing (onClick, on, keyCode, onInput)
import Json.Decode as Json


---- MODEL ----


type alias Model =
    { name : String, textInput : String }


initialModel : Model
initialModel =
    { name = "Steven", textInput = "" }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = Exclaim
    | Reset
    | ChangeName
    | RandomizeName
    | ChangeInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Exclaim ->
            ( { model | name = model.name ++ "!" }, Cmd.none )

        Reset ->
            ( initialModel, Cmd.none )

        ChangeName ->
            ( { model | name = model.textInput }, Cmd.none )

        RandomizeName ->
            update (ChangeInput randomName) model

        ChangeInput newInput ->
            ( { model | textInput = newInput }, Cmd.none )


randomName : String
randomName =
    "so random!"



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div [ onClick Exclaim ] [ text ("Your Elm App is working, " ++ model.name ++ "!") ]
        , button [ onClick Reset ] [ text "Reset" ]
        , button [ onClick RandomizeName ] [ text "Randomize" ]
        , input [ onEnter ChangeName, onInput ChangeInput, value model.textInput ] []
        ]


onEnter : msg -> Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
        on "keydown" (Json.andThen isEnter keyCode)



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
