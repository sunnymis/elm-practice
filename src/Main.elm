module Main exposing (..)

--import Counter exposing (..)

import ReverseString exposing (..)


--import CalorieCounter exposing (..)

import Html exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = ReverseString.model
        , view = ReverseString.view
        , update = ReverseString.update
        }
