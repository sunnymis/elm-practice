module FetchGif exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Debug exposing (..)


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
    { topic : String
    , gifUrl : String
    }


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)
    | NewTopic String


init : ( Model, Cmd Msg )
init =
    ( Model "Cats" "", getRandomGif "Cats" )



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        NewGif retVal ->
            case (log "retVal" retVal) of
                Ok newUrl ->
                    ( { model | gifUrl = newUrl }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        NewTopic newTopic ->
            ( { model | topic = newTopic }, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , input [ onInput NewTopic ] []
        , button [ onClick MorePlease ] [ text "Get Gif!" ]
        , img [ imgStyle, src model.gifUrl ] []
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string


imgStyle : Attribute Msg
imgStyle =
    style
        [ ( "display", "block" )
        ]
