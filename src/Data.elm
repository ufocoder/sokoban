module Data exposing (..)

import Array
import Type exposing (..)


levels: List Level
levels =
  let
    b = Box
    x = BoxOnTarget
    f = Floor
    t = Target
    s = Start
    y = StartOnTarget
    w = Wall
    v = Void
  in
    generateLevels [
      -- level #1
      [ 
        [w, w, w, w],
        [w, f, t, w],
        [w, f, f, w, w, w],
        [w, x, s, f, f, w],
        [w, f, f, b, f, w],
        [w, f, f, w, w, w],
        [w, w, w, w]
      ],
      -- level #2
      [ 
        [w, w, w, w, w, w],
        [w, f, f, f, f, w],
        [w, f, w, b, f, w],
        [w, f, s, x, f, w],
        [w, f, t, x, f, w],
        [w, f, f, f, f, w],
        [w, w, w, w, w, w]
      ],
      -- level #3
      [
        [v, v, w, w, w, w],
        [w, w, w, f, f, w, w, w, w],
        [w, f, f, f, f, f, b, f, w],
        [w, f, w, f, f, w, b, f, w],
        [w, f, t, f, t, w, s, f, w],
        [w, w, w, w, w, w, w, w, w]
      ],
      -- level #4
      [
        [w, w, w, w, w, w, w, w],
        [w, f, f, f, f, f, f, w],
        [w, f, t, x, x, b, s, w],
        [w, f, f, f, f, f, f, w],
        [w, w, w, w, w, f, f, w],
        [v, v, v, v, w, w, w, w]
      ],
      -- level #5
      [
        [v, w, w, w, w, w, w, w],
        [v, w, f, f, f, f, f, w],
        [v, w, f, t, b, t, f, w],
        [w, w, f, b, s, b, f, w],
        [w, f, f, t, b, t, f, w],
        [w, f, f, f, f, f, f, w],
        [w, w, w, w, w, w, w, w]
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
        boxes =  extractPositions positionsTuples [Box, BoxOnTarget],
        target = extractPositions positionsTuples [Target, BoxOnTarget, StartOnTarget],
        wall = extractPositions positionsTuples [Wall],
        floor = extractPositions positionsTuples [Box, BoxOnTarget, Floor, Target, Start, StartOnTarget]
      },
      size = {
        heigth = getLevelHeigth levelData,
        width = getLevelWidth levelData
      },
      player = {
        direction = Left,
        position = extractPlayerPosition positionsTuples
      },
      statistic = {
        moves = 0,
        pushes = 0
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
        |> List.filter (\(x, y, class) -> class == Start || class == StartOnTarget)
        |> List.map (\(x, y, class) -> {x = x, y = y})
  in
    case List.head startPositions of
      Just position ->
        position

      Nothing ->
        {x = 0, y = 0}