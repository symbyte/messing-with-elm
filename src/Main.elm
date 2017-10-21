module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { name : String }


init : ( Model, Cmd Msg )
init =
    ( Model "Steven", Cmd.none )



---- UPDATE ----


type Msg
    = Exclaim


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Exclaim ->
            ( { name = model.name ++ "!" }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div [ onClick Exclaim ] [ text ("Your Elm App is working, " ++ model.name ++ "!") ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
