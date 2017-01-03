import Html exposing (..)
import Keyboard

import Type exposing (..)

import Screen.Intro
import Screen.Level
import Screen.Complete
import Screen.Victory

-- MODEL

model: Model
model =
  {
    screen = ScreenIntro,
    level = Nothing
  }

init: (Model, Cmd Msg)
init = (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions: Model -> Sub Msg
subscriptions model =
  Keyboard.downs KeyDown

-- UPDATE

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case model.screen of
    ScreenIntro ->
      Screen.Intro.update msg model

    ScreenLevel ->
      Screen.Level.update msg model

    ScreenComplete ->
      Screen.Complete.update msg model

    ScreenVictory ->
      (model, Cmd.none)

-- VIEW

view: Model -> Html Msg
view model =
  case model.screen of
    ScreenIntro ->
      Screen.Intro.render model

    ScreenLevel ->
      Screen.Level.render model

    ScreenComplete ->
      Screen.Complete.render model

    ScreenVictory ->
      Screen.Victory.render model

-- MAIN

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
