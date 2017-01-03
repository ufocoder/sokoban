module Data exposing (..)

import Array
import Type exposing (..)


levels: List Level
levels =
  let
    b = Box
    f = Floor
    t = Target
    s = Start
    w = Wall
    v = Void
  in
    generateLevels [
      -- level #1
      [ 
        [v, v, w, w, w, v, v],
        [v, v, w, t, w, v, v],
        [w, w, w, b, w, w, w],
        [w, t, b, s, b, t, w],
        [w, w, w, b, w, w, w],
        [v, v, w, t, w, v, v],
        [v, v, w, w, w, v, v]
      ],
      -- level #2
      [ 
        [v, v, v, v, w, w, w, w, w],
        [v, v, v, v, w, f, f, f, w],
        [v, v, v, v, w, b, f, f, w],
        [v, v, w, w, w, f, f, b, w, w],
        [v, v, w, f, f, b, f, b, f, w],
        [w, w, w, f, w, f, w, w, f, w, v, v, v, w, w, w, w, w, w],
        [w, f, f, f, w, f, w, w, f, w, w, w, w, w, f, f, t, t, w],
        [w, f, b, f, f, b, f, f, f, f, f, s, f, f, f, f, t, t, w],
        [w, w, w, w, w, f, w, w, w, f, w, f, w, w, f, f, t, t, w],
        [v, v, v, v, w, f, f, f, f, f, w, w, w, w, w, w, w, w, w],
        [v, v, v, v, w, w, w, w, w, w, w]
      ]
    ] 


generateLevels: List LevelData -> List Level
generateLevels levelsData =
  levelsData
    |> List.indexedMap (,)
    |> List.map (\(levelNumber, levelData) -> generateLevel levelNumber levelData)


generateLevel: Int -> LevelData -> Level
generateLevel levelNumber levelData =
  let
    positionsTuples = extractPositionTuples levelData
  in
    {
      number = levelNumber,
      map = {
        boxes =  extractPositions positionsTuples [Box],
        target = extractPositions positionsTuples [Target],
        wall = extractPositions positionsTuples [Wall],
        floor = extractPositions positionsTuples [Box, Floor, Target, Start]
      },
      size = {
        heigth = getLevelHeigth levelData,
        width = getLevelWidth levelData
      },
      player = {
        direction = Left,
        position = extractPlayerPosition positionsTuples
      }
    }



getLevelHeigth: LevelData -> Int
getLevelHeigth levelData = 
  List.length levelData


getLevelWidth: LevelData -> Int
getLevelWidth levelData =
  levelData
    |> List.map (\row -> List.length row)
    |> List.maximum
    |> Maybe.withDefault 0


transformRow: (Int, List(Int, Class)) -> List (Int, Int, Class)
transformRow (y, row) =
  List.map (\(x, class) -> (x, y, class)) row


extractPositionTuples: LevelData -> List (Int, Int, Class)
extractPositionTuples levelData  =
  levelData 
    |> List.map (\row -> List.indexedMap (,) row)
    |> List.indexedMap (,)
    |> List.map transformRow
    |> List.concat


extractPositions: List (Int, Int, Class) -> List Class ->List Position
extractPositions positionTuples classList =
  positionTuples
    |> List.filter (\(x, y, class) -> List.member class classList)
    |> List.map (\(x, y, class) -> {x = x, y = y})

extractPlayerPosition: List (Int, Int, Class) -> Position
extractPlayerPosition positionTuples =
  let
    startPositions = 
      positionTuples
        |> List.filter (\(x, y, class) -> class == Start)
        |> List.map (\(x, y, class) -> {x = x, y = y})
  in
    case List.head startPositions of
      Just position ->
        position

      Nothing ->
        {x = 0, y = 0}