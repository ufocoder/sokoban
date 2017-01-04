module Render exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (encodeUri)
import Style
import Type exposing (..)

url: String
url = "https://ufocoder.github.io/sokoban/dist/index.html"

layout: List (Html msg) -> Html msg
layout children =
  Html.div [Style.layout] children


background: Html msg
background =
  Html.div [Style.background] []


logo: String -> Html msg
logo message =
  Html.div [Style.logo] [text message]


menu: String -> Html msg
menu message =
  Html.div [Style.menu] [text message]


title: String -> Html msg
title message =
    Html.div [Style.title] [text message]


shareVictory: String -> Html msg
shareVictory linkText =
  let 
    tweetText = "I win the sokoban game, URL: " ++ url
  in
    Html.div [Style.share] [
      shareTwitterLink linkText tweetText
    ]


shareLevel:  Level -> String -> Html msg
shareLevel level linkText = 
  let
    baseText = (
      "passed level #" ++ (toString (level.number + 1)) ++ ", with " ++ 
      (toString level.statistic.moves) ++ " moves and " ++
      (toString level.statistic.pushes) ++ " pushes"
    )
    shareText = "You " ++ baseText
    tweetText = "I " ++ baseText ++ ", URL: " ++ url
  in
    Html.div [Style.share] [
      Html.div [] [text shareText],
      shareTwitterLink linkText tweetText
    ]


shareTwitterLink: String -> String -> Html msg
shareTwitterLink linkText tweetText =
  Html.a [
    target "_blank",
    href ("https://twitter.com/intent/tweet?text=" ++ (encodeUri tweetText)),
    style [
      ("color", "#FFFFFF")
    ] 
  ] [
    text linkText
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
