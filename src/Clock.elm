module Clock exposing (..)

import Time exposing (Time, second)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (..)


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
    { time : Time
    , paused : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 False, Cmd.none )



-- update


type Msg
    = Tick Time
    | PauseTime


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }, Cmd.none )

        PauseTime ->
            ( { model | paused = not model.paused }, Cmd.none )



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.paused then
        Sub.none
    else
        Time.every second Tick



-- view


view : Model -> Html Msg
view model =
    let
        angle =
            Basics.turns (Time.inMinutes model.time)

        handX =
            toString (50 + 40 * cos angle)

        handY =
            toString (50 + 40 * sin angle)
    in
        div []
            [ svg [ viewBox "0 0 100 100", width "300px" ]
                [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
                , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                ]
            , button [ onClick PauseTime ] [ Html.text (buttonText model.paused) ]
            ]


buttonText : Bool -> String
buttonText paused =
    if paused then
        "Resume"
    else
        "Stop"
