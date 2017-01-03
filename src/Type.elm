module Type exposing (..)

import Keyboard exposing (KeyCode)

type Key
    = Space
    | ArrowUp
    | ArrowDown
    | ArrowLeft
    | ArrowRight

type Direction
  = Up
  | Down
  | Left
  | Right

type alias Position = {
  x: Int,
  y: Int
}

type Class
  = Box
  | Floor
  | Target
  | Start
  | Wall
  | Void

type alias Square = {
  position: Position,
  class: Class
}

type alias Player = {
  direction: Direction,
  position: Position
}

type alias Size = {
    heigth: Int,
    width: Int
  }

type alias Layer = List Position
type alias Layers = List Layer

type alias Map  = {
  boxes: Layer,
  target: Layer,
  wall: Layer,
  floor: Layer
}

type alias Level = {
  number: Int,
  size: Size,
  map: Map,
  player: Player
}

type alias LevelRow = List Class
type alias LevelData = List (List Class)

type Screen
  = ScreenIntro
  | ScreenLevel
  | ScreenComplete
  | ScreenVictory

type alias Model =
  {
    screen: Screen,
    level: Maybe Level
  }

type Msg
  = KeyDown Keyboard.KeyCode

fromKeyCodeToKey: Int -> Maybe Key
fromKeyCodeToKey keyCode =
  case keyCode of
    32 -> Just Space
    37 -> Just ArrowLeft
    39 -> Just ArrowRight
    38 -> Just ArrowUp
    40 -> Just ArrowDown
    _ -> Nothing


fromKeyCodeToDirection: Int -> Maybe Direction
fromKeyCodeToDirection keyCode =
  case keyCode of
    37 -> Just Left
    38 -> Just Up
    39 -> Just Right
    40 -> Just Down
    _  -> Nothing
