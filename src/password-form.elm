module PasswordForm exposing (..)

import Html exposing (..)


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


type Msg
    = AddName
    | AddPassword
    | AddPasswordAgain


model : Model
model =
    Model "" "" ""


update : Model -> Msg -> Model
update model msg =
    case msg of
        _ ->
            Model "" "" ""


view : Model -> Html Msg
view model =
    div [] []


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { mode = model
        , view = view
        , update = update
        }
