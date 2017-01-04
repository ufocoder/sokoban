module Screen.Victory exposing (..)

import Html exposing (..)
import Render exposing (..)
import Type exposing (..)

render: Model -> Html Msg
render model =
  Render.layout [
    Render.title "You win!",
    Render.background
  ]
