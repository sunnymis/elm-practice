module Main exposing (..)

--import Counter exposing (..)
--import ReverseString exposing (..)

import PasswordForm exposing (..)


--import CalorieCounter exposing (..)

import Html exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = PasswordForm.model
        , view = PasswordForm.view
        , update = PasswordForm.update
        }
