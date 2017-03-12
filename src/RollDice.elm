module RollDice exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Random exposing (generate)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- model


type alias Model =
    { dieFace : Int
    }


type Msg
    = Roll
    | NewFace Int


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieFace) ]
        , button [ onClick Roll ] [ text "Roll Dice" ]
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
