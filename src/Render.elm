module Render exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Style
import Type exposing (..)


layout: List (Html msg) -> Html msg
layout children =
  Html.div [Style.layout] children


menu: String -> Html msg
menu message =
  Html.div [Style.menu] [text message]


title: String -> Html msg
title message =
    Html.div [Style.title] [text message]


grid: Size -> List (Html msg) -> Html msg
grid size children =
    Html.div [Style.grid size.heigth size.width] children


layer: Class -> Layer -> Html msg
layer class layer =
  Html.div [] (
    List.map (square class) layer
  )


player: Player -> Html msg
player player =
  Html.div [Style.player player.position player.direction] []


statistic: Statistic -> Html msd
statistic statistic = 
  Html.div [Style.statistic] [
    text (
      "moves " ++ (toString statistic.moves) ++  ", " ++
      "pushes " ++ (toString statistic.pushes)
    )
  ]

square: Class -> Position -> Html msg
square class position =
  case class of
    Box ->
      Html.div [Style.box position] []

    Wall ->
      Html.div [Style.wall position] []

    Target ->
      Html.div [Style.target position] []

    Floor ->
      Html.div [Style.floor position] []

    _ ->
      Html.div [] []
