module Counter exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


-- Main


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- Model


type alias Model =
    Int


model : Model
model =
    0



-- Actions


type Msg
    = Increment
    | Decrement
    | Reset



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0



-- View


view : Model -> Html Msg
view model =
    div []
        [ button [ type_ "button", onClick Increment ] [ text "Increment" ]
        , div [] [ text (toString model) ]
        , button [ type_ "button", onClick Decrement ] [ text "Decrement" ]
        , button [ type_ "button", onClick Reset ] [ text "Reset" ]
        ]
