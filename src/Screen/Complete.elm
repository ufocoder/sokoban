module Screen.Complete exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Keyboard exposing (KeyCode)
import Game exposing (..)
import Render exposing (..)
import Type exposing (..)


render: Model -> Html Msg
render model =
  case model.level of
    Just level ->
      Render.layout [
        Render.title ("Level " ++ (toString (level.number + 1)) ++ " complete"),
        Render.menu "Press spacebar to play next level"
      ]

    Nothing -> 
      Render.layout [
        Render.title "Bad level"
      ]



update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case model.level of
    Just level ->
      case msg of
        KeyDown keyCode ->
          case fromKeyCodeToKey keyCode of
            Just Space ->
              ({model | 
                screen = ScreenLevel,
                level = playLevel (level.number + 1)
                }, Cmd.none)

            _ -> 
              (model, Cmd.none)
    Nothing -> 
      (model, Cmd.none)
