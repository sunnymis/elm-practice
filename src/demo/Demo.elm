module Demo exposing (..)

import Html exposing (..)
import View exposing (..)
import Model exposing (..)
import Update exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = Model.model
        , update = Update.update
        , view = View.view
        }



-- model
-- update
-- view
