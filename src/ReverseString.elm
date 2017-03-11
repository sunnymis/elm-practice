module ReverseString exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { input : String
    }


type Msg
    = Reverse String


model : Model
model =
    { input = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reverse inp ->
            { model | input = String.reverse inp }


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", onInput Reverse, placeholder "Reverse" ] []
        , div [] [ text model.input ]
        ]
