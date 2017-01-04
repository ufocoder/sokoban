module Screen.Intro exposing (..)

import Html exposing (..)
import Render exposing (..)
import Game exposing (..)
import Type exposing (..)


render: Model -> Html Msg
render model =
  Render.layout [
    Render.menu "Press spacebar to start the game",
    Render.background
  ]


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    KeyDown keyCode ->
      case fromKeyCodeToKey keyCode of
        Just Space ->
          ({model | 
            screen = ScreenLevel,
            level = playLevel 0
            }, Cmd.none)

        _ -> 
              (model, Cmd.none)
