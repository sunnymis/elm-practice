module Chat exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


main : Program Never Model MyMsg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- model


type alias Model =
    { input : String
    , messages : List String
    }


init : ( Model, Cmd MyMsg )
init =
    ( Model "" [], Cmd.none )



-- update


type MyMsg
    = Input String
    | Send
    | NewMessage String


update : MyMsg -> Model -> ( Model, Cmd MyMsg )
update msg model =
    case msg of
        Input newContent ->
            ( { model | input = newContent }, Cmd.none )

        Send ->
            ( { model | input = "" }
            , WebSocket.send "ws://echo.websocket.org" model.input
            )

        NewMessage newMsg ->
            ( { model | messages = newMsg :: model.messages }, Cmd.none )



-- subscriptions


subscriptions : Model -> Sub MyMsg
subscriptions model =
    WebSocket.listen "ws://echo.websocket.org" NewMessage



-- view


view : Model -> Html MyMsg
view model =
    div []
        [ input [ onInput Input, value model.input ] []
        , button [ onClick Send ] [ text "Send" ]
        , div [] (List.map viewMessage model.messages)
        ]


viewMessage : String -> Html MyMsg
viewMessage msg =
    div [] [ text msg ]
