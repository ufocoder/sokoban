module Render exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (encodeUri)
import Style
import Type exposing (..)


layout: List (Html msg) -> Html msg
layout children =
  Html.div [Style.layout] children


background: Html msg
background =
  Html.div [Style.background] []


menu: String -> Html msg
menu message =
  Html.div [Style.menu] [text message]


title: String -> Html msg
title message =
    Html.div [Style.title] [text message]


share:  Level -> String -> Html msg
share level message = 
  let
    baseText = (
      "passed level #" ++ (toString level.number) ++ ", with " ++ 
      (toString level.statistic.moves) ++ " moves and " ++
      (toString level.statistic.pushes) ++ " pushes"
    )
    shareText = "You " ++ baseText
    tweetText = "I " ++ baseText
  in
    Html.div [Style.share] [
      Html.div [] [text shareText],
      Html.a [
        target "_blank",
        href ("https://twitter.com/intent/tweet?text=" ++ (encodeUri tweetText)),
        style [
          ("color", "#FFFFFF")
        ]
      ] [
        text message
      ]
    ]


reset: String -> Html msg
reset message =
  Html.div [Style.reset] [text message]


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
