module Screen.Victory exposing (..)

import Html exposing (..)
import Render exposing (..)
import Type exposing (..)

render: Model -> Html Msg
render model =
  Render.layout [
    Render.menu "Congratulations! You win the game!",
    Render.shareVictory "Share your victory in Twitter",
    Render.background
  ]
