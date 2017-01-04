module Screen.Level exposing (..)

import Html exposing (..)
import Render exposing (..)
import Game exposing (..)
import Data exposing (..)
import Type exposing (..)
import Task exposing (..)

render: Model -> Html Msg
render model =
  case model.level of
    Just level ->
      Render.layout [
        Render.title ("Level " ++ (toString (level.number + 1))),
        Render.statistic level.statistic,
        Render.grid level.size [
          Render.player level.player,
          Render.layer Floor level.map.floor,
          Render.layer Wall level.map.wall,
          Render.layer Box level.map.boxes,
          Render.layer Target level.map.target
        ],
        Render.background
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
          case fromKeyCodeToDirection keyCode of
            Just direction ->
              let
                movementMap = extractMovementMap level.map
                nextPosition = move level.player.position direction
                nextPositionAfter = move nextPosition direction
                nextPositionHasBox = hasPosition level.map.boxes nextPosition
                canBoxBeMoved = hasPosition movementMap nextPositionAfter
                canPlayerBeMoved = hasPosition movementMap nextPosition
              in
                if nextPositionHasBox && canBoxBeMoved then
                  let 
                    newModel = {
                      model | level = 
                        level
                          |> movePlayer direction nextPosition
                          |> moveBox direction nextPosition
                          |> Just
                    }
                  in
                    if levelComplete newModel.level then
                      if (level.number + 1) >= List.length levels then 
                        ({model | 
                            screen = ScreenVictory,
                            level = Nothing
                          }, Cmd.none)
                      else
                        ({newModel | screen = ScreenComplete}, Cmd.none)
                    else
                      (newModel, Cmd.none)
                else if canPlayerBeMoved then
                  ({
                    model | level = 
                      level
                        |> movePlayer direction nextPosition
                        |> Just
                    }, Cmd.none)
                else 
                  (model, Cmd.none)

            _ -> 
              (model, Cmd.none)

    Nothing -> 
      (model, Cmd.none)
