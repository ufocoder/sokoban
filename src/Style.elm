module Style exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Type exposing (..)

squareSize: Int
squareSize = 32

toPixels: Int -> String
toPixels size = toString size ++ "px"

toRotateDegree: Direction -> String
toRotateDegree direction = 
  case direction of
    Up ->
      "rotate(" ++ (toString 0) ++ "deg)"

    Down ->
      "rotate(" ++ (toString 180) ++ "deg)"

    Left ->
      "rotate(" ++ (toString -90) ++ "deg)"

    Right ->
      "rotate(" ++ (toString 90) ++ "deg)"

layout: Attribute msg
layout = style
  [
    ("position", "relative")
  ]

background: Attribute msg
background = style
  [
    ("position", "fixed"),
    ("background-color", "#242c2d"),
    ("width", "100%"),
    ("top", "0"),
    ("bottom", "0"),
    ("z-index", "-1")
  ]

menu: Attribute msg
menu = style
  [
    ("position", "absolute"),
    ("top", "280px"),
    ("color", "#FFFFFF"),
    ("font-family", "'Orbitron', sans-serif"),
    ("font-size", "20px"),
    ("line-height", "50px"),
    ("text-align", "center"),
    ("width", "100%")
  ]

logo: Attribute msg
logo = style
  [
    ("position", "absolute"),
    ("top", "240px"),
    ("color", "#FFFFFF"),
    ("font-family", "'Orbitron', sans-serif"),
    ("font-size", "40px"),
    ("line-height", "50px"),
    ("text-align", "center"),
    ("width", "100%")
  ]

share: Attribute msg
share = style
  [
    ("position", "absolute"),
    ("top", "290px"),
    ("color", "#949494"),
    ("font-family", "'Orbitron', sans-serif"),
    ("font-size", "14px"),
    ("line-height", "22px"),
    ("text-align", "center"),
    ("width", "100%")
  ]

title: Attribute msg
title = style
  [
    ("position", "relative"),
    ("color", "#efefef"),
    ("font-family", "'Orbitron', sans-serif"),
    ("font-size", "40px"),
    ("line-height", "40px"),
    ("text-align", "center"),
    ("width", "100%")
  ]

statistic: Attribute msg
statistic =
  style [
    ("position", "relative"),
    ("color", "#bac4c5"),
    ("font-family", "'Orbitron', sans-serif"),
    ("font-size", "16px"),
    ("line-heigth", "16px"),
    ("text-align", "center"),
    ("margin-bottom", "40px"),
    ("width", "100%")
  ]


reset: Attribute msg
reset = style
  [
    ("position", "relative"),
    ("color", "#efefef"),
    ("font-family", "'Orbitron', sans-serif"),
    ("font-size", "14px"),
    ("text-align", "center"),
    ("margin-top", "40px"),
    ("width", "100%")
  ]


grid: Int -> Int -> Attribute msg
grid height width = style
  [
    ("position", "relative"),
    ("height", toPixels (height * squareSize)),
    ("width", toPixels (width * squareSize)),
    ("margin", "0 auto")
  ]


layer: Int -> Attribute msg
layer zIndex = style
  [
    ("position", "relative"),
    ("zIndex", toString zIndex)
  ]

player: Position -> Direction -> Attribute msg
player position direction =
  style (
    List.append
      (baseSquare position)
      [
        ("background-image", "url('../dist/assets/player.png')"),
        ("background-size", "100% 100%"),
        ("transition", "0.15s linear"),
        ("z-index", "999"),
        ("-webkit-transform", toRotateDegree direction),
        ("-moz-transform", toRotateDegree direction),
        ("-ms-transform", toRotateDegree direction),
        ("-o-transform", toRotateDegree direction),
        ("transform", toRotateDegree direction)
      ]
  )


baseSquare: Position -> List (String, String)
baseSquare position =
  [
    ("position", "absolute"),
    ("height", toPixels squareSize),
    ("width", toPixels squareSize),
    ("left", toPixels (squareSize * position.x)),
    ("top", toPixels (squareSize * position.y))
  ]


target: Position -> Attribute msg
target position =
  style (
    List.append
      (baseSquare position)
      [
        ("background-image", "url('../dist/assets/target.png')"),
        ("background-size", "100% 100%")
      ]
  )

box: Position -> Attribute msg
box position =
  style (
    List.append
      (baseSquare position)
      [
        ("background-image", "url('../dist/assets/box.png')"),
        ("background-size", "100% 100%"),
        ("transition", "0.15s linear"),
        ("-webkit-box-shadow", "1px 1px 1px 0px rgba(0,0,0,0.25)"),
        ("-moz-box-shadow", "1px 1px 1px 0px rgba(0,0,0,0.25)"),
        ("box-shadow", "1px 1px 1px 0px rgba(0,0,0,0.25)")
      ]
  )


floor: Position -> Attribute msg
floor position =
  style (
    List.append
      (baseSquare position)
      [
        ("background-color", "#6c7a7c"),
        ("background-image", "url('../dist/assets/floor.jpg')"),
        ("background-size", "100% 100%")
      ]
  )


wall: Position -> Attribute msg
wall position =
  style (
    List.append
      (baseSquare position)
      [
        ("background-color", "#161c1d"),
        ("background-image", "url('../dist/assets/wall.png')"),
        ("background-size", "100% 100%"),
        ("-webkit-box-shadow", "1px 1px 1px 0px rgba(0,0,0,0.25)"),
        ("-moz-box-shadow", "1px 1px 1px 0px rgba(0,0,0,0.25)"),
        ("box-shadow", "1px 1px 1px 0px rgba(0,0,0,0.25)")
      ]
  )
