module Game exposing (..)

import Array
import Type exposing (..)
import Data exposing (..)


playLevel: Int -> Maybe Level
playLevel levelNumber =
  levels 
    |> Array.fromList
    |> Array.get levelNumber


-- Map functions

extractMovementMap: Map -> Layer
extractMovementMap map = 
  map.floor
    |> List.filter (\floor -> not (List.member floor map.boxes))


hasPosition: Layer -> Position -> Bool
hasPosition layer position =
  layer 
    |> List.filter (\square -> square.x == position.x && square.y == position.y)
    |> List.isEmpty
    |> not


levelComplete: Maybe Level -> Bool
levelComplete level =
  case level of 
    Just level ->
      level.map.target 
        |> List.map (\position -> List.member position level.map.boxes)
        |> List.filter (\present -> not present)
        |> List.isEmpty

    Nothing ->
      False


-- Move functions


movePlayer: Direction -> Position -> Level -> Level
movePlayer direction position level = 
  let 
    gamePlayer = level.player
    levelStatistic = level.statistic
  in
    {
      level | 
        statistic = {
          levelStatistic | moves = levelStatistic.moves + 1
        },
        player = {
          gamePlayer | 
            position = position,
            direction = direction
        }
    }

moveBox: Direction -> Position -> Level -> Level
moveBox direction position level =
  let 
    levelMap = level.map
    levelStatistic = level.statistic
    mapBoxes = levelMap.boxes
      |> List.map (
        \square -> 
          if square.x == position.x && square.y == position.y then
            move square direction
          else 
            square
        )
  in
    {
      level | 
        statistic = {
          levelStatistic | pushes = levelStatistic.pushes + 1
        },
        map = {
          levelMap | boxes = mapBoxes
        }
    }

move: Position -> Direction -> Position
move position direction =
  case direction of
    Up ->
      {position | y = position.y - 1}

    Down ->
      {position | y = position.y + 1}

    Left ->
      {position | x = position.x - 1}

    Right ->
      {position | x = position.x + 1}
